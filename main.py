import psycopg2
from config import DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT

def connect_to_db():
    """Conecta ao banco de dados PostgreSQL."""
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        return conn
    except Exception as e:
        print("Erro ao conectar ao banco de dados:", e)
        return None

def execute_query(conn, query, params=None):
    """Executa a consulta SQL e retorna os resultados."""
    try:
        with conn.cursor() as cursor:
            cursor.execute(query, params)
            results = cursor.fetchall()
            return results
    except Exception as e:
        print("Erro ao executar a consulta:", e)
        return None

def menu():
    """Menu principal para consultas."""
    print("\n\n")
    print("Menu de Consultas:")
    print("1. Que tipo de serviços um determinado cliente X solicitou no último mês")
    print("2. Qual é a empresa que mais ofereceu mais serviços à cidade de Y no estado de Z")
    print("3. Quais funcionários (nome e sobrenome) trabalharam para o cliente X no mês Y do ano Z")
    print("4. Listar as solicitações foram feitas no último ano, nome do cliente que as realizou, municípios de origem e destino (se houver) e preço total de cada solicitação.")
    print("5. Listar o faturamento das empresas por mês em um ano X")
    print("6. Verificar qual o serviço mais solicitado no último mês entre todas empresas")
    print("7. Listar o serviço (nome) mais solicitado, e o número de solicitações para cada empresa")
    print("8. Verificar em qual a cidade houve o maior número de solicitações.")
    print("9. Verificar qual a cidade destino que é mais referenciada nos pedidos e a sua quantidade de pedidos.")
    print("10. Listar para cada empresa o seu faturamento total.")
    print("0. Sair")
    return input("Escolha uma opção: ")

def main():
    conn = connect_to_db()
    if not conn:
        return
    
    while True:
        option = menu()
        
        if option == "1":
            cliente_id = input("Digite o ID do cliente: ")
            query = """
                SELECT s.nome_servico
                FROM pedido_servico ps
                JOIN pedido p ON ps.id_pedido = p.id
                join empresa_servico_cidade esc  on ps.id_empresa_servico_cidade = esc.id
                JOIN servico s ON esc.id_servico = s.id
                WHERE p.id_cliente = %s
                AND p.data_solicitacao >= CURRENT_DATE - INTERVAL '1 month';
            """
            results = execute_query(conn, query, (cliente_id,))
        
        elif option == "2":
            cidade = input("Digite o nome da cidade: ")
            estado = input("Digite o estado (sigla): ")
            query = """
                SELECT e.nome
                FROM Empresa_Servico_Cidade esc
                JOIN Empresa_de_Mudancas e ON esc.id_empresa = e.id
                JOIN Cidade c ON esc.id_cidade = c.id
                WHERE c.nome_cidade = %s AND c.estado = %s
                GROUP BY e.nome
                ORDER BY COUNT(*) DESC
                LIMIT 1;
            """
            results = execute_query(conn, query, (cidade, estado))
        
        elif option == "3":
            cliente_id = input("Digite o ID do cliente: ")
            mes = input("Digite o mês (MM): ")
            ano = input("Digite o ano (AAAA): ")
            query = """
                SELECT f.nome_completo
                FROM Pedido_Servico_Funcionario psf
                JOIN Pedido_Servico ps ON psf.id_pedido_servico = ps.id
                JOIN Pedido p ON ps.id_pedido = p.id
                JOIN Funcionario f ON psf.id_funcionario = f.id
                WHERE p.id_cliente = %s
                AND EXTRACT(MONTH FROM p.data_solicitacao) = %s
                AND EXTRACT(YEAR FROM p.data_solicitacao) = %s;
            """
            results = execute_query(conn, query, (cliente_id, mes, ano))
        
        elif option == "4":
            query = """
                SELECT p.codigo_pedido, c.nome_completo, e1.nome_cidade AS origem, e2.nome_cidade AS destino, p.preco_total
                FROM Pedido p
                JOIN Cliente c ON p.id_cliente = c.id
                JOIN Endereco e1 ON p.id_endereco_partida = e1.id
                JOIN Endereco e2 ON p.id_endereco_destino = e2.id
                WHERE p.data_solicitacao >= CURRENT_DATE - INTERVAL '1 year';
            """
            results = execute_query(conn, query)
        
        elif option == "5":
            ano = input("Digite o ano (AAAA): ")
            query = """
                SELECT e.nome, TO_CHAR(p.data_solicitacao, 'YYYY-MM') AS mes, SUM(p.preco_total) AS faturamento
                FROM Pedido p
                JOIN Empresa_Servico_Cidade esc ON p.id_empresa_servico_cidade = esc.id
                JOIN Empresa_de_Mudancas e ON esc.id_empresa = e.id
                WHERE EXTRACT(YEAR FROM p.data_solicitacao) = %s
                GROUP BY e.nome, TO_CHAR(p.data_solicitacao, 'YYYY-MM')
                ORDER BY e.nome, mes;
            """
            results = execute_query(conn, query, (ano,))
        
        elif option == "6":
            query = """
                SELECT s.nome_servico, COUNT(*) AS total
                FROM Pedido_Servico ps
                JOIN Servico s ON ps.id_servico = s.id
                JOIN Pedido p ON ps.id_pedido = p.id
                WHERE p.data_solicitacao >= CURRENT_DATE - INTERVAL '1 month'
                GROUP BY s.nome_servico
                ORDER BY total DESC
                LIMIT 1;
            """
            results = execute_query(conn, query)
        
        elif option == "0":
            print("Saindo...")
            break
        
        else:
            print("Opção inválida!")
            continue

        if results:
            print()
            print("Resultado da consulta: ")
            for row in results:
                print(" - " + ", ".join(str(value) for value in row))
        else:
            print("Nenhum resultado encontrado.")

    conn.close()

if __name__ == "__main__":
    main()
