DELIMITER $$
DROP PROCEDURE IF EXISTS pc_cargo_cad$$
CREATE PROCEDURE pc_cargo_cad (IN pc_nome varchar(50), IN pc_salario decimal(10,2), OUT pc_msg varchar(200))
BEGIN
/*
Data: 15/05/2022
Autor: Bruno Irineu 
Objetivo: cadastrar e verificar dados do cargo.
*/
	-- VALIDAR CARGO
	SET @valor =( select count(*) from cargo as c where c.cargo_nome = pc_nome);
	IF(@valor > 0 ) THEN
		set @valornome = (select c.cargo_nome from cargo as c where c.cargo_nome = pc_nome);
        set pc_msg = concat(@valornome, " Já existe esse cargo cadastrado !");
        -- VALIDAR DADOS
        ELSEIF (pc_nome = "" OR pc_nome IS NULL OR length(trim(pc_nome)) = 0 ) THEN
			SET pc_msg = "Campo Nome deve receber um valor diferente de nulo ou vazio";
		ELSEIF (pc_salario = "" OR pc_salario IS NULL) THEN
			SET pc_msg = "Campo Salário deve receber um valor diferente de nulo";
		ELSEIF (pc_salario <= 1.100) THEN
			SET pc_msg = "O salário base deve ser maior que R$ 1.100 !";
	ELSE
		INSERT INTO cargo(cargo_nome, cargo_sal_base) values (trim(pc_nome), trim(pc_salario));
        SET pc_msg = "Inserido com Sucesso!";
        -- verificação
	END IF;
END $$
DELIMITER ;

CALL pc_cargo_cad ("taquigrafo", 3500,@msg);
select @msg;
