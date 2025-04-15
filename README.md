# Projeto1-Banco-de-dados

## Integrantes:
-  Paulo Andre de Oliveira Hirata RA: 22.125.072-3
-  Victor Merker Binda RA: 22.125.075-6

## Descrição do Projeto:
O objetivo deste projeto é implementar um sistema de banco de dados para uma universidade. O sistema deve ser capaz de armazenar e gerenciar informações relacionadas a alunos, professores, departamentos, cursos, disciplinas, históricos escolares de alunos, histórico de disciplinas lecionadas por professores, TCCs apresentados considerando tanto o grupo de alunos como o professor orientador.

### Recursos usados:
- Supabase
- SQL
- python
- ERDplus

## Funcionamento do projeto:
**1** - Mostre todo o histórico escolar de um aluno que teve reprovação em uma disciplina, retornando inclusive a reprovação em um semestre e a aprovação no semestre seguinte;

**2** - Mostre todos os TCCs orientados por um professor junto com os nomes dos alunos que fizeram o projeto;

**3** - Mostre a matriz curicular de pelo menos 2 cursos diferentes que possuem disciplinas em comum (e.g., Ciência da Computação e Ciência de Dados). Este exercício deve ser dividido em 2 queries sendo uma para cada curso;

**4**- Para um determinado aluno, mostre os códigos e nomes das diciplinas já cursadas junto com os nomes dos professores que lecionaram a disciplina para o aluno;

**5** - Liste todos os chefes de departamento e coordenadores de curso em apenas uma query de forma que a primeira coluna seja o nome do professor, a segunda o nome do departamento coordena e a terceira o nome do curso que coordena. Substitua os campos em branco do 
resultado da query pelo texto "nenhum"

**6** - mais outras 10 querys selecionadas de uma lista.

### Como executar:

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/poulison/Projeto1-Banco-de-dados.git
   cd Projeto1-Banco-de-dados
2. **Instale os pacotes necessários (python):**
   ```bash
    python -m venv venv
    source venv/bin/activate     # Linux/macOS
    venv\Scripts\activate        # Windows

    pip install -r requirements.txt
3. **Configure os dados de acesso do Supabase:** No arquivo [ROBO.py](https://github.com/poulison/Projeto1-Banco-de-dados/blob/main/ROBO.py), edite os campos abaixo com os dados do seu projeto:
   ```bash
    SUPABASE_USER = 'postgres'
    SUPABASE_PASSWORD = 'SUA_SENHA'
    SUPABASE_HOST = 'db.XXXX.supabase.co'
    SUPABASE_PORT = '5432'
    SUPABASE_DB = 'postgres'
4. **Crie as tabelas no Supabase:** No painel do Supabase (SQL Editor), execute o conteúdo do arquivo [criaçãotabelas.sql](https://github.com/poulison/Projeto1-Banco-de-dados/blob/main/criaçãodastabelas.sql):
    ```bash
 
    database/create_tables.sql

5.
##  Modelo Entidade Relacionamento:
![image](https://github.com/user-attachments/assets/7f737c81-f79c-4d0a-a186-4d801beeaa9e)


##  Modelo Relacional :
![image](https://github.com/user-attachments/assets/64178ba5-f44d-4180-b06c-e7a420d2d982)


