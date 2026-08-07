CREATE INDEX idx_produtos_mais_vendidos
ON Vendas (quantidade)
WHERE quantidade >= 10; 
