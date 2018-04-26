<?php
    require ('./Conexion.php');
$query="call p_selectequipoficha()";
mysqli_query($conexion,$query) or die(mysqli_error());
mysqli_close($conexion);