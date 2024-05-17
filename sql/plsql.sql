-- Atividade 01

CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome IN VARCHAR2,
    p_responsavel IN VARCHAR2
) AS
BEGIN
    INSERT INTO projeto (nome, responsavel)
    VALUES (p_nome, p_responsavel);
    COMMIT;
END;

BEGIN
    brh.insere_projeto('SQLSERVER', 'F123');
END;

-- Atividade 02

create or replace NONEDITIONABLE FUNCTION     calcula_idade (
    p_data_nascimento IN dependente.data_nascimento%TYPE
) RETURN NUMBER
IS
    v_idade NUMBER;
BEGIN
    -- Calcula a idade a partir da data de nascimento
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, p_data_nascimento) / 12) INTO v_idade FROM dependente WHERE ROWNUM = 1;
    RETURN v_idade;
END;

SELECT brh.calcula_idade(data_nascimento) AS idade FROM dependente;

-- Atividade 03

CREATE OR REPLACE FUNCTION brh.finaliza_projeto (
    p_id_projeto IN NUMBER
) RETURN DATE
IS
    v_data_finalizacao DATE;
BEGIN
    v_data_finalizacao := SYSDATE;
    UPDATE projeto
    SET fim = v_data_finalizacao
    WHERE id = p_id_projeto;
    RETURN v_data_finalizacao;
END;

SET SERVEROUTPUT ON;
DECLARE
    v_data DATE;
BEGIN
    v_data := brh.finaliza_projeto(1);
    DBMS_OUTPUT.PUT_LINE('Data de finalização: ' || TO_CHAR(v_data, 'DD/MM/YYYY HH24:MI:SS'));
    COMMIT; 
END;

-- Atividade 04
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome IN VARCHAR2,
    p_responsavel IN VARCHAR2
) AS
BEGIN
    IF p_nome IS NULL OR LENGTH(p_nome) < 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    END IF;

    INSERT INTO projeto (nome, responsavel)
    VALUES (p_nome, p_responsavel);
    COMMIT;
END;
