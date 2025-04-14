
--verifica a consistecia dos dados


-- 1. Alunos com curso inexistente
SELECT * FROM aluno
WHERE id_curso NOT IN (SELECT id_curso FROM curso);

-- 2. Professores com departamento inexistente
SELECT * FROM professor
WHERE id_departamento NOT IN (SELECT id_departamento FROM departamento);

-- 3. Cursos com coordenador inexistente
SELECT * FROM curso
WHERE coordenador_id NOT IN (SELECT id_professor FROM professor);

-- 4. Cursos com departamento inexistente
SELECT * FROM curso
WHERE id_departamento NOT IN (SELECT id_departamento FROM departamento);

-- 5. TCCs com orientador inexistente
SELECT * FROM tcc
WHERE id_orientador NOT IN (SELECT id_professor FROM professor);

-- 6. TCC_Aluno com tcc inexistente
SELECT * FROM tcc_aluno
WHERE id_tcc NOT IN (SELECT id_tcc FROM tcc);

-- 7. TCC_Aluno com aluno inexistente
SELECT * FROM tcc_aluno
WHERE id_aluno NOT IN (SELECT id_aluno FROM aluno);

-- 8. Disciplinas lecionadas com professor inexistente
SELECT * FROM disciplinaslecionadas
WHERE id_professor NOT IN (SELECT id_professor FROM professor);

-- 9. Disciplinas lecionadas com disciplina inexistente
SELECT * FROM disciplinaslecionadas
WHERE id_disciplina NOT IN (SELECT id_disciplina FROM disciplina);

-- 10. Matriz curricular com curso inexistente
SELECT * FROM matrizcurricular
WHERE id_curso NOT IN (SELECT id_curso FROM curso);

-- 11. Matriz curricular com disciplina inexistente
SELECT * FROM matrizcurricular
WHERE id_disciplina NOT IN (SELECT id_disciplina FROM disciplina);

-- 12. Histórico escolar com aluno inexistente
SELECT * FROM historicoescolar
WHERE id_aluno NOT IN (SELECT id_aluno FROM aluno);

-- 13. Histórico escolar com disciplina inexistente
SELECT * FROM historicoescolar
WHERE id_disciplina NOT IN (SELECT id_disciplina FROM disciplina);
