tabla_para_xg <- data.table::as.data.table(expand.grid(tipo_de_tiro = c("General", "7m", "Penetración", "Extremo", "Contragolpe"),
                                                       larga_distancia = c(TRUE, FALSE),
                                                       marco_vacio = c(TRUE, FALSE),
                                                       posicion = c('left', 'right', 'centre')))

tabla_para_xg <- tabla_para_xg[!(larga_distancia == TRUE & tipo_de_tiro != 'General')]
tabla_para_xg <- tabla_para_xg[!(tipo_de_tiro == 'Extremo' & posicion == 'centre')]

tabla_para_xg[tipo_de_tiro == 'Penetración', posicion_tiro := 'breakthrough']
tabla_para_xg[tipo_de_tiro == 'Contragolpe', posicion_tiro := 'fast break']
tabla_para_xg[tipo_de_tiro == '7m', posicion_tiro := 'Penalty']
tabla_para_xg[tipo_de_tiro == 'Extremo', posicion_tiro := paste(posicion, 'wing')]
tabla_para_xg[marco_vacio == TRUE, posicion_tiro := 'empty goal']
tabla_para_xg[is.na(posicion_tiro) & larga_distancia == TRUE, posicion_tiro := paste(posicion, '9m')]
tabla_para_xg[is.na(posicion_tiro), posicion_tiro := paste(posicion, '6m')]

tabla_para_xg[handbaloner::xg_egipto21, xg := i.xg, on = 'posicion_tiro']


data.table::fwrite(tabla_para_xg, 'tabla_para_xg.csv')
