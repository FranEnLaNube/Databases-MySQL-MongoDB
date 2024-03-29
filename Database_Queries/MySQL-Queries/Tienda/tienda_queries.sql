USE tienda;

SELECT 
    nombre AS 'Productos'
FROM
    producto;

SELECT 
    nombre 'Producto', precio 'Precio'
FROM
    producto;

SELECT 
    *
FROM
    producto;
	# O si quiero mostrar las columnas que tiene junto con más info:
SHOW COLUMNS FROM producto;

SELECT 
    nombre AS 'Productos',
    precio AS 'Precio EUR',
    ROUND(precio * 1.07, 2) AS 'Precio USD'
FROM
    producto

#5. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans. Utilitza els següents àlies per a les columnes: nom de "producto", euros, dòlars nord-americans.
SELECT 
    nombre AS 'Nom de producto',
    precio AS 'Euros',
    ROUND(precio * 1.07, 2) AS 'Dòlars nord-americans'
FROM
    producto;

#6. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a majúscula.
	# UPPER() y UCASE() funcionan igual
SELECT 
    UPPER(nombre) AS 'Nombre en mayúscula', precio
FROM
    producto;

#7. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a minúscula.
	# LOWER() y LCASE() funcionan igual
SELECT 
    LOWER(nombre) AS 'Nombre en minúscula', precio
FROM
    producto;

#8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
	# Se puede usar MID(), SUBSTR() o SUBSTRING(), son lo mismo.
    # Aceptan 3 parámetros, el texto a cortar, la posición de comienzo, y cuántas letras saca (opcional).
SELECT 
    nombre AS 'Fabricante',
    UPPER(MID(nombre, 1, 2)) AS 'Extracto Fabricante'
FROM
    fabricante;

#9. Llista els noms i els preus de tots els productes de la taula "producto", arrodonint el valor del preu.
	# En la funcion ROUND después del nombre de la columna va la cantidad de decimales que quieres.
SELECT 
    nombre AS Producto, ROUND(precio, 0) AS 'Precio redondeado'
FROM
    producto;

#10. Llista els noms i els preus de tots els productes de la taula "producto", truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
	#La función TRUNCATE() opera igual a la de ROUND(), pero trunca, no redondea.
SELECT 
    nombre AS Producto, TRUNCATE(precio, 0) AS 'Precio truncado'
FROM
    producto;

#11. Llista el codi dels fabricants que tenen productes en la taula "producto".
	# Usando subconsultas
SELECT 
    codigo
FROM
    fabricante
WHERE
    codigo IN (SELECT 
            codigo_fabricante
        FROM
            producto);    
	# Usando INNER JOIN (la palabra INNER se puede omitir)
		#Selecciono solo los que cumplen con la condicion
SELECT 
    f.codigo AS 'Código de fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo;

#12. Llista el codi dels fabricants que tenen productes en la taula "producto", eliminant els codis que apareixen repetits.
	# Usando Subconsulta
SELECT 
    codigo
FROM
    fabricante
WHERE
    codigo IN (SELECT DISTINCT
            codigo_fabricante
        FROM
            producto);
    # Usando INNER JOIN
		# Con DISTINCT traigo solo la primera aparición de registros iguales en todos los campos.
SELECT DISTINCT
    f.codigo AS 'Código de fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo;

#13. Llista els noms dels fabricants ordenats de manera ascendent.
	# ASC es por defecto, se puede obviar.
SELECT 
    nombre AS 'Nombre fabricante'
FROM
    fabricante
ORDER BY nombre ASC;

#14. Llista els noms dels fabricants ordenats de manera descendent.
	# Los String se ordenan alfabéticamente.
SELECT 
    nombre AS 'Nombre fabricante'
FROM
    fabricante
ORDER BY nombre DESC;

#15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
	# Por defecto es ASC y no hace falta llamar a las columnas por las que voy a ordenar.
SELECT 
    nombre AS 'Nombre producto'
FROM
    producto
ORDER BY nombre , precio DESC;

#16. Retorna una llista amb les 5 primeres files de la taula "fabricante".
SELECT 
    *
FROM
    fabricante
LIMIT 5;

#17. Retorna una llista amb 2 files a partir de la quarta fila de la taula "fabricante". La quarta fila també s'ha d'incloure en la resposta.
	# LIMIT tiene dos argumentos, el 1ro es desde dónde (empieza en 0) y el 2do es cuántas.
SELECT 
    *
FROM
    fabricante
LIMIT 3 , 2;

#18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MIN(preu), necessitaries GROUP BY
SELECT 
    nombre AS 'Producto más barato',
    precio AS 'Al módico precio de'
FROM
    producto
ORDER BY precio
LIMIT 1;

#19. Llista el nom i el preu del producte més car. (Fes servir solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podries usar MAX(preu), necessitaries GROUP BY.
SELECT 
    nombre AS 'Producto más caro',
    precio AS 'Al pequeño pastón de'
FROM
    producto
ORDER BY precio DESC
LIMIT 1;

#20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT 
    nombre AS 'Nombre producto'
FROM
    producto AS p
WHERE
    codigo_fabricante = 2;

#21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT 
    p.nombre AS 'Producto',
    precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo;

#22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT 
    p.nombre AS 'Producto',
    precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

#23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant, de tots els productes de la base de dades.
SELECT 
    p.codigo AS 'Código producto',
    p.nombre AS 'Producto',
    f.codigo AS 'Código fabricante',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo;

#24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT 
    p.nombre AS 'Producto más barato',
    precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio
LIMIT 1;

#25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT 
    p.nombre AS 'Producto más caro',
    p.precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;

#26. Retorna una llista de tots els productes del fabricant Lenovo.
SELECT 
    *
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Lenovo';

#27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT 
    *
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Crucial' AND p.precio > 200;

#28. Retorna una llista amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
SELECT 
    *
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Asus'
        OR f.nombre = 'Hewlett-Packard'
        OR f.nombre = 'Seagate';

#29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Usant l'operador IN.
SELECT 
    *
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre IN ('Asus' , 'Hewlett-Packard', 'Seagate');

#30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT 
    p.nombre AS 'Producto', p.precio AS 'Precio'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre LIKE '%e';

#31. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants dels quals contingui el caràcter w en el seu nom.
SELECT 
    p.nombre AS 'Producto', p.precio AS 'Precio'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre LIKE '%w%';

#32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT 
    p.nombre AS 'Producto',
    p.precio AS 'Precio',
    f.nombre AS 'Fabricante'
FROM
    producto AS p
        INNER JOIN
    fabricante AS f ON p.codigo_fabricante = f.codigo
WHERE
    p.precio >= 180
ORDER BY p.precio DESC , p.nombre;

#33. Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT
    f.codigo AS 'Código fabricante', f.nombre AS 'Fabricante'
FROM
    fabricante AS f
        INNER JOIN
    producto AS p ON f.codigo = p.codigo_fabricante;

#34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
	# Traigo todos los productos de fabricante y su unión con productos
SELECT 
    *
FROM
    fabricante AS f
        LEFT JOIN
    producto AS p ON p.codigo_fabricante = f.codigo;

#35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
	# Opcion con LEFT JOIN
	# Filtro los resultados que no tienen vinculación
SELECT 
    *
FROM
    fabricante AS f
        LEFT JOIN
    producto AS p ON p.codigo_fabricante = f.codigo
WHERE
    p.nombre IS NULL;
    # Opción con NOT EXISTS
SELECT 
    *
FROM
    fabricante f
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            producto p
        WHERE
            f.codigo = p.codigo_fabricante);

#36. Retorna tots els productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).
	# Utilizo una subconsulta
SELECT 
	*
FROM
    producto AS p
WHERE
    p.codigo_fabricante = (SELECT 
            f.codigo
        FROM
            fabricante AS f
        WHERE
            f.nombre = 'Lenovo');

#37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense fer servir INNER JOIN).
	# Empleando subconsultas
SELECT 
    *
FROM
    producto p
WHERE
    p.precio = (SELECT 
            MAX(p.precio)
        FROM
            producto p
        WHERE
            p.codigo_fabricante = (SELECT 
                    f.codigo
                FROM
                    fabricante f
                WHERE
                    f.nombre = 'Lenovo'));

#38. Llista el nom del producte més car del fabricant Lenovo.
	# Sin usar JOIN
SELECT 
    p.nombre 'Producto más caro de Lenovo'
FROM
    producto p
WHERE
    p.precio = (SELECT 
            MAX(p.precio)
        FROM
            producto p
        WHERE
            p.codigo_fabricante = (SELECT 
                    f.codigo
                FROM
                    fabricante f
                WHERE
                    f.nombre = 'Lenovo'));
	# Usando JOIN
SELECT 
    p.nombre 'Producto más caro de Lenovo'
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    p.precio = (SELECT 
            MAX(p.precio)
        FROM
            producto p
                JOIN
            fabricante f ON p.codigo_fabricante = f.codigo
        WHERE
            f.nombre = 'Lenovo');
	# Usando ORDER BY Y LIMIT
SELECT 
    p.nombre 'Producto más caro de Lenovo'
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Lenovo'
ORDER BY p.precio DESC
LIMIT 1;

#39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
	#También se pueden usar las alternativas del #38
    #Opto por ORDER BY Y LIMIT:
SELECT 
    p.nombre 'Producto Hewlett-Packard más barato'
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    f.nombre = 'Hewlett-Packard'
ORDER BY p.precio
LIMIT 1;
	#Sin usar JOIN
SELECT 
    p.nombre 'Producto Hewlett-Packard más barato'
FROM
    producto p
WHERE
    p.precio = (SELECT 
            MIN(p.precio)
        FROM
            producto p
        WHERE
            p.codigo_fabricante = (SELECT 
                    f.codigo
                FROM
                    fabricante f
                WHERE
                    f.nombre = 'Hewlett-Packard'));

#40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
	# Obtengo el más caro de Lenovo con la consulta del #38 y la uso en el WHERE del SELECT p.nombre
    # También se pueden usar las alternativas del #38
SELECT 
    *
FROM
    producto p
WHERE
    p.precio >= (SELECT 
            MAX(p.precio)
        FROM
            producto p
        WHERE
            p.codigo_fabricante = (SELECT 
                    f.codigo
                FROM
                    fabricante f
                WHERE
                    f.nombre = 'Lenovo'));
	# Ejemplo con JOIN, que me permite traer también el nombre del fabricante
SELECT 
    p.nombre 'Productos igual o más caros que Lenovo',
    f.nombre 'Fabricante'
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    p.precio >= (SELECT 
            MAX(p.precio)
        FROM
            producto p
                JOIN
            fabricante f ON p.codigo_fabricante = f.codigo
        WHERE
            f.nombre = 'Lenovo');

#41. Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
	#Aquí usando subconsulta solamente
SELECT 
    p.nombre 'Productos caros de Asus'
FROM
    producto p
WHERE
    p.precio > (SELECT 
            AVG(p.precio)
        FROM
            producto p
        WHERE
            p.codigo_fabricante = (SELECT 
                    f.codigo
                FROM
                    fabricante f
                WHERE
                    f.nombre = 'Asus'))
        AND p.codigo_fabricante = (SELECT 
            f.codigo
        FROM
            fabricante f
        WHERE
            f.nombre = 'Asus');
	# Pero también se podría usar JOIN
SELECT 
    p.nombre 'Productos caros de Asus', f.nombre 'Fabricante'
FROM
    producto p
        JOIN
    fabricante f ON p.codigo_fabricante = f.codigo
WHERE
    p.precio > (SELECT 
            AVG(p.precio)
        FROM
            producto p
                JOIN
            fabricante f ON p.codigo_fabricante = f.codigo
        WHERE
            f.nombre = 'Asus')
        AND f.nombre = 'Asus';