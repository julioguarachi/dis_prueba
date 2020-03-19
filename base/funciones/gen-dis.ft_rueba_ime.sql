CREATE OR REPLACE FUNCTION "dis"."ft_rueba_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		DISTRIBUCION
 FUNCION: 		dis.ft_rueba_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dis.prueba'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2020 02:06:40
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				19-03-2020 02:06:40								Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dis.prueba'	
 #
 ***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id	integer;
			    
BEGIN

    v_nombre_funcion = 'dis.ft_rueba_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIS_pru_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2020 02:06:40
	***********************************/

	if(p_transaccion='DIS_pru_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dis.prueba(
			descripcion
          	) values(
			v_parametros.descripcion
							
			
			
			)RETURNING id into v_id;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','prueba almacenado(a) con exito (id'||v_id||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id',v_id::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DIS_pru_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2020 02:06:40
	***********************************/

	elsif(p_transaccion='DIS_pru_MOD')then

		begin
			--Sentencia de la modificacion
			update dis.prueba set
			descripcion = v_parametros.descripcion,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id=v_parametros.id;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','prueba modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id',v_parametros.id::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DIS_pru_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2020 02:06:40
	***********************************/

	elsif(p_transaccion='DIS_pru_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dis.prueba
            where id=v_parametros.id;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','prueba eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id',v_parametros.id::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION
				
	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "dis"."ft_rueba_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
