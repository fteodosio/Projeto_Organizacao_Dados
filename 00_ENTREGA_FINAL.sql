-- PASSO 1: Eliminar tabelas temporárias e de testes que já não são necessárias
DROP TABLE IF EXISTS tmp_importacao_excel;
DROP TABLE IF EXISTS teste_vendas_antigo;
-- PASSO 2: Purga de logs de auditoria com mais de 90 dias
-- (Mantém apenas o histórico recente para poupar espaço)
DELETE FROM auditoria_logs
WHERE data_operacao < NOW() - INTERVAL '90 days';
-- PASSO 3: Recomprimir espaço e reindexar a base de dados
-- O VACUUM limpa o espaço "morto" deixado pelos registos apagados
VACUUM ANALYZE;
-- PASSO 4: Confirmação de execução
SELECT 'LIMPEZA E OTIMIZAÇÃO CONCLUÍDAS COM SUCESSO' AS
resultado_manutencao,
 NOW() AS data_execucao; 

-- Consulta do catálogo do sistema para auditoria de tabelas e views
SELECT 
    table_schema, 
    table_name, 
    table_type 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_type, table_name; 
