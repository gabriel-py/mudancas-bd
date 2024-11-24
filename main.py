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
                SELECT DISTINCT f.nome_completo
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
                SELECT 
                    p.codigo_pedido AS pedido_codigo,
                    c.nome_completo AS cliente_nome,
                    cidade_origem.nome_cidade AS municipio_origem,
                    cidade_destino.nome_cidade AS municipio_destino,
                    p.preco_total AS preco_total
                FROM Pedido p
                JOIN Cliente c ON p.id_cliente = c.id
                LEFT JOIN Endereco endereco_origem ON p.id_endereco_partida = endereco_origem.id
                LEFT JOIN Cidade cidade_origem ON endereco_origem.id_cidade = cidade_origem.id
                LEFT JOIN Endereco endereco_destino ON p.id_endereco_destino = endereco_destino.id
                LEFT JOIN Cidade cidade_destino ON endereco_destino.id_cidade = cidade_destino.id
                WHERE p.data_solicitacao >= CURRENT_DATE - INTERVAL '1 year';
            """
            results = execute_query(conn, query)
        
        elif option == "5":
            ano = input("Digite o ano (AAAA): ")

            # a seguinte query retorna o faturamente agrupado por mês, porém só exibe registros de meses que o faturamente tenha sido diferente de 0. Ou seja, se o faturamente = 0 em um mês, ele não vai ser retornado
            query = """
                SELECT e.nome, TO_CHAR(p.data_solicitacao, 'YYYY-MM') AS mes, SUM(p.preco_total) AS faturamento
                FROM Pedido p
                JOIN pedido_servico ps ON ps.id_pedido = p.id
                JOIN Empresa_Servico_Cidade esc ON ps.id_empresa_servico_cidade = esc.id
                JOIN Empresa_de_Mudancas e ON esc.id_empresa = e.id
                WHERE EXTRACT(YEAR FROM p.data_solicitacao) = %s
                GROUP BY e.nome, TO_CHAR(p.data_solicitacao, 'YYYY-MM')
                ORDER BY e.nome, mes;
            """

            # a seguinte query retorna resultado para todos os meses do ano, mesmo que o faturamente = 0
            # query = """ 
            #     WITH meses AS (
            #         SELECT TO_CHAR(date_trunc('month', (DATE '2024-01-01' + (n || ' months')::interval)), 'YYYY-MM') AS mes
            #         FROM generate_series(0, 11) n
            #     ),
            #     empresas AS (
            #         SELECT DISTINCT e.nome AS empresa_nome
            #         FROM Empresa_de_Mudancas e
            #     ),
            #     todos_meses AS (
            #         SELECT e.empresa_nome, m.mes
            #         FROM empresas e
            #         CROSS JOIN meses m
            #     )
            #     SELECT 
            #         tm.empresa_nome, 
            #         tm.mes, 
            #         COALESCE(SUM(p.preco_total), 0) AS faturamento
            #     FROM todos_meses tm
            #     LEFT JOIN Pedido p ON TO_CHAR(p.data_solicitacao, 'YYYY-MM') = tm.mes
            #     LEFT JOIN Pedido_Servico ps ON p.id = ps.id_pedido
            #     LEFT JOIN Empresa_Servico_Cidade esc ON ps.id_empresa_servico_cidade = esc.id
            #     LEFT JOIN Empresa_de_Mudancas e ON esc.id_empresa = e.id AND e.nome = tm.empresa_nome
            #     WHERE EXTRACT(YEAR FROM p.data_solicitacao) = 2024 OR p.id IS NULL
            #     GROUP BY tm.empresa_nome, tm.mes
            #     ORDER BY tm.empresa_nome, tm.mes;
            # """

            results = execute_query(conn, query, (ano,))

        elif option == "6":
            query = """
                SELECT s.nome_servico, COUNT(*) AS total
                FROM Pedido_Servico ps
                JOIN Empresa_Servico_Cidade esc ON ps.id_empresa_servico_cidade = esc.id
                JOIN Servico s ON esc.id_servico = s.id
                JOIN Pedido p ON ps.id_pedido = p.id
                WHERE p.data_solicitacao >= CURRENT_DATE - INTERVAL '1 month'
                GROUP BY s.nome_servico
                ORDER BY total DESC
                LIMIT 1;
            """
            results = execute_query(conn, query)
        
        elif option == "7":
            query = """
                SELECT 
                    e.nome AS empresa_nome, 
                    s.nome_servico, 
                    COUNT(*) AS total_solicitacoes
                FROM Pedido_Servico ps
                JOIN Empresa_Servico_Cidade esc ON ps.id_empresa_servico_cidade = esc.id
                JOIN Empresa_de_Mudancas e ON esc.id_empresa = e.id
                JOIN Servico s ON esc.id_servico = s.id
                GROUP BY e.nome, s.nome_servico
                ORDER BY e.nome, total_solicitacoes DESC;
            """
            results = execute_query(conn, query)

        elif option == "8":
            query = """
                SELECT 
                    c.nome_cidade
                FROM Pedido p
                JOIN Endereco e ON p.id_endereco_partida = e.id
                JOIN Cidade c ON e.id_cidade = c.id
                GROUP BY c.nome_cidade
                ORDER BY COUNT(*) DESC
                LIMIT 1;
            """
            results = execute_query(conn, query)

        elif option == "9":
            query = """
                SELECT 
                    c.nome_cidade, 
                    COUNT(*) AS total_solicitacoes
                FROM Pedido p
                JOIN Endereco e ON p.id_endereco_destino = e.id
                JOIN Cidade c ON e.id_cidade = c.id
                GROUP BY c.nome_cidade
                ORDER BY total_solicitacoes DESC
                LIMIT 1;
            """
            results = execute_query(conn, query)

        elif option == "10":
            query = """
                SELECT 
                    e.nome AS empresa_nome, 
                    COALESCE(SUM(p.preco_total), 0) AS faturamento_total
                FROM Empresa_de_Mudancas e
                LEFT JOIN Empresa_Servico_Cidade esc ON e.id = esc.id_empresa
                LEFT JOIN Pedido_Servico ps ON esc.id = ps.id_empresa_servico_cidade
                LEFT JOIN Pedido p ON ps.id_pedido = p.id
                GROUP BY e.nome
                ORDER BY faturamento_total DESC;
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
