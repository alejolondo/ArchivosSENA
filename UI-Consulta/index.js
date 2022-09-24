const btnConsulta = document.getElementById('btn-consulta')
const fechaInicio = document.getElementById('hora-inicio').value 
const fechaFinal = document.getElementById('hora-final').value

btnConsulta.addEventListener("click", ()=>{

    
    const datos = {
            fechaInicio: fechaInicio,
            fechaFin: fechaFinal
          
    }

function traerdatos(data){
    
        let html = ` 

        <section id="encabezado">
          <p>Nombres</p>
          <p>Apellidos</p>
          <p>Identificación</p>
          <p>Factor</p>
          <p>Puntaje</p>
          <p>Fecha de registro</p>
      
        </section>
        `
        

        for (let dato of data) {
            
        if(dato.esAlerta){
                html += `
              
        <section class = "tuplaDiferente">
              <p>${dato.nombres}</p>
              <p>${dato.apellidos}</p>
              <p>${dato.identificacion}</p>
              <p>${dato.factor}</p>
              <p>${dato.puntaje}</p>
              <p>${dato.fechaRgistro}</p>

        </section> `   
            }else{
                html += `
                  
                <section class = "tupla">
                      <p>${dato.nombres}</p>
                      <p>${dato.apellidos}</p>
                      <p>${dato.identificacion}</p>
                      <p>${dato.factor}</p>
                      <p>${dato.puntaje}</p>
                      <p>${dato.fechaRgistro}</p>
    
                </section>    
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