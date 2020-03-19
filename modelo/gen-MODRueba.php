<?php
/**
*@package pXP
*@file gen-MODRueba.php
*@author  (admin)
*@date 19-03-2020 02:06:40
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODRueba extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarRueba(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dis.ft_rueba_sel';
		$this->transaccion='DIS_pru_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id','int4');
		$this->captura('descripcion','varchar');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarRueba(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dis.ft_rueba_ime';
		$this->transaccion='DIS_pru_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarRueba(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dis.ft_rueba_ime';
		$this->transaccion='DIS_pru_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id','id','int4');
		$this->setParametro('descripcion','descripcion','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarRueba(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dis.ft_rueba_ime';
		$this->transaccion='DIS_pru_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id','id','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>