from sqlalchemy import create_engine, text
from urllib.parse import quote_plus
from faker import Faker
import unicodedata
import pandas as pd
import random
import traceback


def limpa_str(texto):
    if not isinstance(texto, str):
        return texto
    return unicodedata.normalize('NFKD', texto).encode('ASCII', 'ignore').decode('utf-8')

fake = Faker('pt_BR')


SUPABASE_USER = 'postgres.yfozykiaapityhkkkige'
SUPABASE_PASSWORD = quote_plus('Binda2004')
SUPABASE_HOST = 'aws-0-us-east-1.pooler.supabase.com'
SUPABASE_PORT = '5432'
SUPABASE_DB = 'postgres'

DATABASE_URL = f"postgresql+psycopg2://{SUPABASE_USER}:{SUPABASE_PASSWORD}@{SUPABASE_HOST}:{SUPABASE_PORT}/{SUPABASE_DB}"
engine = create_engine(
    DATABASE_URL,
    connect_args={"sslmode": "require"}
)

print("Testando conexão com o Supabase...")
try:
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
        print(" Conexão bem-sucedida!")
except Exception as e:
    print(f" Falha na conexão: {e}")


def gerar_departamentos():
    nomes = [limpa_str(n) for n in ['Ciência da Computação', 'Engenharia', 'Matemática']]
    return pd.DataFrame([
        {'id_departamento': i + 1, 'nome': nome}
        for i, nome in enumerate(nomes)
    ])

def gerar_professores(qtd, id_departamentos_possiveis):
    return pd.DataFrame([
        {
            'id_professor': i + 1,
            'nome': limpa_str(fake.name()),
            'id_departamento': random.choice(id_departamentos_possiveis)
        }
        for i in range(qtd)
    ])

def gerar_cursos():
    return pd.DataFrame([
        {'id_curso': 1, 'nome': limpa_str('Ciência da Computação'), 'coordenador_id': 1, 'id_departamento': 1},
        {'id_curso': 2, 'nome': limpa_str('Ciência de Dados'), 'coordenador_id': 2, 'id_departamento': 1}
    ])

def gerar_alunos(qtd, id_curso_possiveis):
    return pd.DataFrame([
        {
            'id_aluno': i + 1,
            'nome': limpa_str(fake.name()),
            'ra': f"{random.randint(100000, 999999)}",
            'id_curso': random.choice(id_curso_possiveis)
        }
        for i in range(qtd)
    ])

def gerar_disciplinas():
    nomes = [limpa_str(n) for n in ['Algoritmos', 'Estrutura de Dados', 'Banco de Dados', 'Matemática Discreta', 'Estatística']]
    return pd.DataFrame([
        {'id_disciplina': i + 1, 'nome': nome, 'carga_horaria': random.choice([60, 80])}
        for i, nome in enumerate(nomes)
    ])

def gerar_matriz_curricular():
    matriz = []
    for curso_id in [1, 2]:
        for disc_id in [1, 2, 3, 4, 5]:
            if curso_id == 1 or disc_id in [3, 4, 5]:
                matriz.append({'id_curso': curso_id, 'id_disciplina': disc_id, 'semestre': random.randint(1, 8)})
    return pd.DataFrame(matriz)

def gerar_disciplinas_lecionadas():
    dados = []
    for prof_id in range(1, 6):
        for disc_id in random.sample(range(1, 6), k=2):
            dados.append({
                'id_professor': prof_id,
                'id_disciplina': disc_id,
                'semestre': random.choice(['1', '2']),
                'ano': random.choice([2023, 2024])
            })
    return pd.DataFrame(dados)

def gerar_historico_escolar(alunos, disciplinas):
    historico = []
    for _, aluno in alunos.iterrows():
        for disc_id in random.sample(list(disciplinas['id_disciplina']), k=3):
            nota = round(random.uniform(0, 10), 2)
            status = limpa_str('Aprovado') if nota >= 5 else limpa_str('Reprovado')
            historico.append({
                'id_aluno': aluno['id_aluno'],
                'id_disciplina': disc_id,
                'semestre': random.choice(['1', '2']),
                'ano': random.choice([2023, 2024]),
                'nota': nota,
                'status': status
            })
    return pd.DataFrame(historico)

def gerar_tccs(professores, alunos):
    tccs = []
    tcc_alunos = []
    for tcc_id in range(1, 4):
        orientador_id = random.choice(list(professores['id_professor']))
        titulo = limpa_str(fake.text(max_nb_chars=30))
        tccs.append({
            'id_tcc': tcc_id,
            'titulo': titulo,
            'ano': 2024,
            'semestre': '2',
            'id_orientador': orientador_id
        })
        participantes = random.sample(list(alunos['id_aluno']), k=2)
        for aluno_id in participantes:
            tcc_alunos.append({'id_tcc': tcc_id, 'id_aluno': aluno_id})
    return pd.DataFrame(tccs), pd.DataFrame(tcc_alunos)


def inserir_tabela(nome_tabela, df):
    try:
        df.to_sql(nome_tabela, engine, if_exists='append', index=False, method='multi')
        print(f" Dados inseridos na tabela '{nome_tabela}'")
    except Exception as e:
        print(f" Erro ao inserir na tabela '{nome_tabela}': {e}")
        traceback.print_exc()


if __name__ == "__main__":
    print("Conectando ao Supabase...")

    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        print(" Conexão com o banco estabelecida com sucesso.")
    except Exception as e:
        print(" Falha na conexão:", e)

    departamentos_df = gerar_departamentos()
    professores_df = gerar_professores(5, [1, 2, 3])
    cursos_df = gerar_cursos()
    alunos_df = gerar_alunos(10, [1, 2])
    disciplinas_df = gerar_disciplinas()
    matriz_df = gerar_matriz_curricular()
    lecionadas_df = gerar_disciplinas_lecionadas()
    historico_df = gerar_historico_escolar(alunos_df, disciplinas_df)
    tcc_df, tcc_aluno_df = gerar_tccs(professores_df, alunos_df)

    inserir_tabela("departamento", departamentos_df)
    inserir_tabela("professor", professores_df)
    inserir_tabela("curso", cursos_df)
    inserir_tabela("aluno", alunos_df)
    inserir_tabela("disciplina", disciplinas_df)
    inserir_tabela("matrizcurricular", matriz_df)
    inserir_tabela("disciplinaslecionadas", lecionadas_df)
    inserir_tabela("historicoescolar", historico_df)
    inserir_tabela("tcc", tcc_df)
    inserir_tabela("tcc_aluno", tcc_aluno_df)

    print("🏁 Finalizado com sucesso!")
