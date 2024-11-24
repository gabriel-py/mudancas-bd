CREATE OR REPLACE FUNCTION atualizar_preco_pedido()
RETURNS TRIGGER AS $$
DECLARE
    preco_hora FLOAT;
    taxa_excedente FLOAT;
    horas_executadas FLOAT;
    preco_calculado FLOAT;
BEGIN
    SELECT esc.preco_hora, esc.taxa_excedente
    INTO preco_hora, taxa_excedente
    FROM Empresa_Servico_Cidade esc
    WHERE esc.id = NEW.id;

    SELECT SUM(EXTRACT(EPOCH FROM ps.tempo_execucao) / 3600)
    INTO horas_executadas
    FROM Pedido_Servico ps
    WHERE ps.id_empresa_servico_cidade = NEW.id;

    preco_calculado := preco_hora * horas_executadas + taxa_excedente;

    UPDATE Pedido
    SET preco_total = preco_calculado
    WHERE id = (
        SELECT ps.id_pedido
        FROM Pedido_Servico ps
        WHERE ps.id_empresa_servico_cidade = NEW.id
        LIMIT 1
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_preco
BEFORE INSERT OR UPDATE ON empresa_servico_cidade
FOR EACH ROW
EXECUTE FUNCTION atualizar_preco_pedido();

CREATE TRIGGER trigger_atualizar_preco
BEFORE INSERT OR UPDATE ON pedido_servico
FOR EACH ROW
EXECUTE FUNCTION atualizar_preco_pedido();
