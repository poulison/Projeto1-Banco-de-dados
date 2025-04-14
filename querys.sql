SELECT 
    h.id_aluno,
    a.nome AS nome_aluno,
    h.id_disciplina,
    d.nome AS nome_disciplina,
    h.semestre,
    h.ano,
    h.nota,
    h.status
FROM HistoricoEscolar h
JOIN Aluno a ON h.id_aluno = a.id_aluno
JOIN Disciplina d ON h.id_disciplina = d.id_disciplina
WHERE h.id_aluno IN (
    SELECT id_aluno
    FROM HistoricoEscolar
    WHERE status = 'Reprovado'
)
ORDER BY h.id_aluno, h.id_disciplina, h.ano, h.semestre;


SELECT 
    p.nome AS nome_orientador,
    t.titulo AS titulo_tcc,
    a.nome AS nome_aluno
FROM TCC t
JOIN Professor p ON t.id_orientador = p.id_professor
JOIN TCC_Aluno ta ON t.id_tcc = ta.id_tcc
JOIN Aluno a ON ta.id_aluno = a.id_aluno
ORDER BY nome_orientador, titulo_tcc;

SELECT 
    c.nome AS nome_curso,
    d.nome AS nome_disciplina,
    m.semestre
FROM MatrizCurricular m
JOIN Curso c ON m.id_curso = c.id_curso
JOIN Disciplina d ON m.id_disciplina = d.id_disciplina
WHERE m.id_curso = 1;


SELECT 
    c.nome AS nome_curso,
    d.nome AS nome_disciplina,
    m.semestre
FROM MatrizCurricular m
JOIN Curso c ON m.id_curso = c.id_curso
JOIN Disciplina d ON m.id_disciplina = d.id_disciplina
WHERE m.id_curso = 2;

SELECT DISTINCT 
    d.id_disciplina,
    d.nome AS nome_disciplina,
    p.nome AS nome_professor
FROM HistoricoEscolar h
JOIN Disciplina d ON h.id_disciplina = d.id_disciplina
JOIN DisciplinasLecionadas dl ON dl.id_disciplina = d.id_disciplina AND dl.ano = h.ano AND dl.semestre = h.semestre
JOIN Professor p ON dl.id_professor = p.id_professor
WHERE h.id_aluno = 1;

SELECT 
    COALESCE(p.nome, 'nenhum') AS nome_professor,
    COALESCE(d.nome, 'nenhum') AS departamento_que_coordena,
    COALESCE(c.nome, 'nenhum') AS curso_que_coordena
FROM Professor p
LEFT JOIN Departamento d ON d.chefe_id = p.id_professor
LEFT JOIN Curso c ON c.coordenador_id = p.id_professor
ORDER BY nome_professor;

--////////////////////////////////////////////////////////////////////
--1
SELECT nome FROM Aluno;

--2
SELECT id_professor, nome FROM Professor;

-- 3. Estudantes orientados por um professor específico (ex: id_professor = 1)
SELECT a.nome, a.id_aluno, t.id_tcc
FROM tcc t
JOIN tcc_aluno ta ON t.id_tcc = ta.id_tcc
JOIN aluno a ON ta.id_aluno = a.id_aluno
WHERE t.id_orientador = 3;



-- 4. Estudantes que cursam "Ciência da Computação" ou "Ciência de Dados"
SELECT a.nome
FROM aluno a
JOIN curso c ON a.id_curso = c.id_curso
WHERE a.id_curso = 2 -- ceincia de dados
   OR a.id_curso = 1; --m ciencia da computacao
 

-- 5. Estudantes que cursaram disciplinas do departamento de "Matemática"
SELECT DISTINCT a.nome
FROM aluno a
JOIN historicoescolar h ON a.id_aluno = h.id_aluno
JOIN disciplina d ON h.id_disciplina = d.id_disciplina
JOIN matrizcurricular mc ON d.id_disciplina = mc.id_disciplina
JOIN curso c ON mc.id_curso = c.id_curso
JOIN departamento dp ON c.id_departamento = dp.id_departamento
WHERE dp.nome = 'Ciencia da Computacao';

-- 6. Estudantes matriculados em cursos do departamento de "Ciência da Computação"
SELECT a.nome
FROM aluno a
JOIN curso c ON a.id_curso = c.id_curso
JOIN departamento d ON c.id_departamento = d.id_departamento
WHERE d.nome = 'Ciencia da Computacao';

select * FROM departamento

-- 7. Estudantes que cursaram "Algoritmos" no semestre 1 de 2024
SELECT DISTINCT a.nome
FROM aluno a
JOIN historicoescolar h ON a.id_aluno = h.id_aluno
JOIN disciplina d ON h.id_disciplina = d.id_disciplina
WHERE d.nome = 'Banco de Dados' AND h.ano = 2024 AND h.semestre = '1';

-- 8. Total de carga horária (créditos) cursada por cada estudante
SELECT a.nome, SUM(d.carga_horaria) AS total_creditos
FROM aluno a
JOIN historicoescolar h ON a.id_aluno = h.id_aluno
JOIN disciplina d ON h.id_disciplina = d.id_disciplina
GROUP BY a.nome;

-- 9. Total de alunos por curso
SELECT c.nome AS curso, COUNT(a.id_aluno) AS total_alunos
FROM curso c
LEFT JOIN aluno a ON c.id_curso = a.id_curso
GROUP BY c.nome;

-- 10. Estudantes orientados por professores que lecionam a disciplina "Inteligência Artificial"
SELECT DISTINCT a.nome
FROM aluno a
JOIN tcc_aluno ta ON a.id_aluno = ta.id_aluno
JOIN tcc t ON ta.id_tcc = t.id_tcc
WHERE t.id_orientador IN (
    SELECT DISTINCT id_professor
    FROM disciplinaslecionadas dl
    JOIN disciplina d ON dl.id_disciplina = d.id_disciplina
    WHERE d.nome = 'Estrutura de Dados'
);


