INSERT INTO usuario (login, senha)
VALUES ('op1', 'op1'),
       ('op2', 'op2');

INSERT INTO produto (nome, quantidade, preco_venda)
VALUES ('Banana', 100, 5.00),
       ('Laranja', 500, 2.00),
       ('Manga', 800, 4.00);

INSERT INTO pessoa (nome, logradouro, cidade, estado, telefone, email)
VALUES ('Joao', 'Rua 12, casa 3, Quitanda', 'Riacho do Sul', 'PA', '1111-1111', 'joao@riacho.com');

INSERT INTO pessoa_fisica (idpessoa, cpf)
VALUES (SCOPE_IDENTITY(), '11111111111');

INSERT INTO pessoa (nome, logradouro, cidade, estado, telefone, email)
VALUES ('JJC', 'Rua 11, Centro', 'Riacho do Norte', 'PA', '1212-1212', 'jjc@riacho.com');

INSERT INTO pessoa_juridica (idpessoa, cnpj)
VALUES (SCOPE_IDENTITY(), '2222222222222');

INSERT INTO movimento (idusuario, idpessoa, idproduto, tipo_movimento, quantidade, valor_unitario)
VALUES (1, 1, 1, 's', 20, 5.00),
       (1, 1, 2, 's', 15, 2.00),
       (2, 1, 2, 's', 10, 2.00),
       (1, 2, 2, 'e', 15, 5.00),
       (1, 2, 3, 'e', 20, 4.00);

SELECT p.id,
       p.nome,
       p.logradouro,
       p.cidade,
       p.estado,
       p.telefone,
       p.email,
       pf.cpf
FROM pessoa p
INNER JOIN pessoa_fisica pf ON p.id = pf.idpessoa;


SELECT p.id,
       p.nome,
       p.logradouro,
       p.cidade,
       p.estado,
       p.telefone,
       p.email,
       pj.cnpj
FROM pessoa p
INNER JOIN pessoa_juridica pj ON p.id = pj.idpessoa;


SELECT p.nome,
       p2.nome AS fornecedor,
       m.quantidade,
       m.valor_unitario,
       (m.valor_unitario * m.quantidade) AS valor_total
FROM movimento m
INNER JOIN produto p ON m.idproduto = p.id
INNER JOIN pessoa p2 ON m.idpessoa = p2.id
INNER JOIN pessoa_juridica pj ON p2.id = pj.idpessoa
WHERE tipo_movimento = 'e';


SELECT p.nome,
       p2.nome AS comprador,
       m.quantidade,
       m.valor_unitario,
       (m.valor_unitario * m.quantidade) AS valor_total
FROM movimento m
INNER JOIN produto p ON m.idproduto = p.id
INNER JOIN pessoa p2 ON m.idpessoa = p2.id
INNER JOIN pessoa_fisica pf ON p2.id = pf.idpessoa
WHERE tipo_movimento = 's';


SELECT p.id,
       p.nome,
       sum(m.valor_unitario * m.quantidade) AS 'valor total'
FROM movimento m
INNER JOIN produto p ON m.idproduto = p.id
WHERE tipo_movimento = 'e'
GROUP BY p.id,
         p.nome;


SELECT p.id,
       p.nome,
       sum(m.valor_unitario * m.quantidade) AS 'valor total'
FROM movimento m
INNER JOIN produto p ON m.idproduto = p.id
WHERE tipo_movimento = 's'
GROUP BY p.id,
         p.nome;

SELECT id,
       [login]
FROM usuario
WHERE id not in
    (SELECT DISTINCT idusuario
     FROM movimento
     WHERE tipo_movimento = 'e');

SELECT u.id,
       u.[login],
       sum(m.valor_unitario * m.quantidade) AS 'valor total'
FROM movimento m
INNER JOIN usuario u ON m.idusuario = u.id
WHERE tipo_movimento = 'e'
GROUP BY u.id,
         u.[login];


SELECT u.id,
       u.[login],
       sum(m.valor_unitario * m.quantidade) AS 'valor total'
FROM movimento m
INNER JOIN usuario u ON m.idusuario = u.id
WHERE tipo_movimento = 's'
GROUP BY u.id,
         u.[login];

SELECT avg(valor_unitario) AS 'valor medio'
FROM movimento
WHERE tipo_movimento = 's'
GROUP BY idproduto