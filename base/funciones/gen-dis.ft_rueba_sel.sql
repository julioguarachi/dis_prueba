CREATE OR REPLACE FUNCTION "dis"."ft_rueba_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		DISTRIBUCION
 FUNCION: 		dis.ft_rueba_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dis.prueba'
 AUTOR: 		 (admin)
 FECHA:	        19-03-2020 02:06:40
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				19-03-2020 02:06:40								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dis.prueba'	
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'dis.ft_rueba_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DIS_pru_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		19-03-2020 02:06:40
	***********************************/

	if(p_transaccion='DIS_pru_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						pru.id,
						pru.descripcion,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dis.prueba pru
						inner join segu.tusuario usu1 on usu1.id_usuario = pru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pru.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DIS_pru_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		19-03-2020 02:06:40
	***********************************/

	elsif(p_transaccion='DIS_pru_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id)
					    from dis.prueba pru
					    inner join segu.tusuario usu1 on usu1.id_usuario = pru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = pru.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
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
ALTER FUNCTION "dis"."ft_rueba_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
