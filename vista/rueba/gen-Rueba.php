<?php
/**
*@package pXP
*@file gen-Rueba.php
*@author  (admin)
*@date 19-03-2020 02:06:40
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Rueba=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Rueba.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
				type:'TextField',
				filters:{pfiltro:'pru.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		}
	],
	tam_pag:50,	
	title:'prueba',
	ActSave:'../../sis_sis_distribucion/control/Rueba/insertarRueba',
	ActDel:'../../sis_sis_distribucion/control/Rueba/eliminarRueba',
	ActList:'../../sis_sis_distribucion/control/Rueba/listarRueba',
	id_store:'id',
	fields: [
		{name:'id', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		