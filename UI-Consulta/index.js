const btnConsulta = document.getElementById('btn-consulta')

btnConsulta.addEventListener("click", () => {

    const fechaInicio = document.getElementById('hora-inicio').value
    const fechaFinal = document.getElementById('hora-final').value

    const datos = {
        fechaInicio: fechaInicio,
        fechaFin: fechaFinal

    }

    function traerdatos(data) {

        let html = ` 

        <table>
                <tr class="encabezado" >
                    <td>Nombre</td>
                    <td>Apellidos</td>
                    <td>Identificación</td>
                    <td>Factor</td>
                    <td>Puntaje</td>
                    <td>Fecha Registro</td>

                </tr>
                
        `


        for (let dato of data) {

            if (dato.esAlerta) {
                html += `
                            
                <tr class = "tuplaDiferente">
                    <td>${dato.nombres}</td>
                    <td>${dato.apellidos}</td>
                    <td>${dato.identificacion}</td>
                    <td>${dato.factor}</td>
                    <td>${dato.puntaje}</td>
                    <td>${dato.fechaRegistro.slice(0,10)}</td>

                </tr>
                `
            } else {
                html += `
                  
                
                <tr >
                    <td>${dato.nombres}</td>
                    <td>${dato.apellidos}</td>
                    <td>${dato.identificacion}</td>
                    <td>${dato.factor}</td>
                    <td>${dato.puntaje}</td>
                    <td>${dato.fechaRegistro.slice(0,10)}</td>

                </tr>
                  
                    `
            }

        }



        document.getElementById('datos-consulta').innerHTML = html

    }



    const options = {
        method: "POST",
        body: JSON.stringify(datos),
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
        }
    }


    fetch("https://tdsbotapi-v01.azurewebsites.net/api/Consultas/Consulta", options)
        .then(response => response.json())
        .then(data => traerdatos(data))
})

// console.log(data) .then(data => traerdatos(data))