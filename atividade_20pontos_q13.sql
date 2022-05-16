DELIMITER $$
DROP PROCEDURE IF EXISTS pc_funcionario_del$$
CREATE PROCEDURE pc_funcionario_del (IN pc_id int, OUT pc_msg varchar(200))
BEGIN
/*
Data: 15/05/2022
Autor: Bruno Irineu 
Objetivo: excluir o cadastro do funcionario.
*/
	-- VALIDAR CARGO
	SET @valor =( select count(*) from funcionario as f where f.func_id = pc_id);
	IF(@valor = 0 ) THEN
        set pc_msg = concat(@pc_id, " O ID não está cadastrado !");
        -- VALIDAR DADOS
		ELSEIF (pc_id = "" OR pc_id IS NULL) THEN
			SET pc_msg = "Campo ID deve receber um valor diferente de nulo";
		ELSEIF (pc_id <= 0 OR pc_id IS NULL) THEN
			SET pc_msg = "Campo ID deve receber um valor maior que zero";
	ELSE
		DELETE FROM funcionario WHERE func_id = pc_id;
        SET pc_msg = "Deletado com Sucesso!";
        -- verificação
	END IF;
END $$
DELIMITER ;


call pc_funcionario_del (1,@msg);
select @msg;
