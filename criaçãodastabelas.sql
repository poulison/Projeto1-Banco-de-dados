CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nome VARCHAR(100),
    chefe_id INT -- FK para Professor
);

CREATE TABLE Professor (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

ALTER TABLE Departamento
ADD CONSTRAINT fk_chefe FOREIGN KEY (chefe_id) REFERENCES Professor(id_professor);

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nome VARCHAR(100),
    coordenador_id INT, -- FK para Professor
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento),
    FOREIGN KEY (coordenador_id) REFERENCES Professor(id_professor)
);

CREATE TABLE Aluno (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100),
    ra VARCHAR(20) UNIQUE,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Disciplina (
    id_disciplina INT PRIMARY KEY,
    nome VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE MatrizCurricular (
    id_curso INT,
    id_disciplina INT,
    semestre INT,
    PRIMARY KEY (id_curso, id_disciplina),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);

CREATE TABLE DisciplinasLecionadas (
    id_professor INT,
    id_disciplina INT,
    semestre VARCHAR(10),
    ano INT,
    PRIMARY KEY (id_professor, id_disciplina, semestre, ano),
    FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);

CREATE TABLE HistoricoEscolar (
    id_aluno INT,
    id_disciplina INT,
    semestre VARCHAR(10),
    ano INT,
    nota DECIMAL(4,2),
    status VARCHAR(20), -- 'Aprovado' ou 'Reprovado'
    PRIMARY KEY (id_aluno, id_disciplina, semestre, ano),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);

CREATE TABLE TCC (
    id_tcc INT PRIMARY KEY,
    titulo VARCHAR(200),
    ano INT,
    semestre VARCHAR(10),
    id_orientador INT,
    FOREIGN KEY (id_orientador) REFERENCES Professor(id_professor)
);

CREATE TABLE TCC_Aluno (
    id_tcc INT,
    id_aluno INT,
    PRIMARY KEY (id_tcc, id_aluno),
    FOREIGN KEY (id_tcc) REFERENCES TCC(id_tcc),
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);




/*
testes

*/

SELECT * FROM professor
