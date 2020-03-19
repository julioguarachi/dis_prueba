<?php
/**
*@package pXP
*@file gen-ACTRueba.php
*@author  (admin)
*@date 19-03-2020 02:06:40
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTRueba extends ACTbase{    
			
	function listarRueba(){
		$this->objParam->defecto('ordenacion','id');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODRueba','listarRueba');
		} else{
			$this->objFunc=$this->create('MODRueba');
			
			$this->res=$this->objFunc->listarRueba($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarRueba(){
		$this->objFunc=$this->create('MODRueba');	
		if($this->objParam->insertar('id')){
			$this->res=$this->objFunc->insertarRueba($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarRueba($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarRueba(){
			$this->objFunc=$this->create('MODRueba');	
		$this->res=$this->objFunc->eliminarRueba($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>