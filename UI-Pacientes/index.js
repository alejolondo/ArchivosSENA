

document.getElementById('registrar').addEventListener("click", () => {
	
    const nombre = document.getElementById("primer-nombre").value
    const segundoNombre = document.getElementById("segundo-nombre").value
    const apellido = document.getElementById("primer-apellido").value
    const segundoApellido = document.getElementById("segundo-apellido").value
    const tipoDocumento = document.getElementById('tipo-documento').value
    const numeroDocumento = document.getElementById('numero-documento').value
    const numeroCelular = document.getElementById('numero-celular').value
    const factores = document.getElementById('factores').value
    let factorId = 0
    const idPaciente = ''
    

    if (factores == 'Depresion'){
        factorId = 1
    }
    else  {
        factorId = 2
    }     


console.log(factorId)

const datosPaciente = {
            paciente: {
                pacienteId: 0,
                primerNombre: nombre,
                segundoNombre: segundoNombre,
                primerApellido: apellido,
                segundoApellido: segundoApellido,
                tipoDocumento: tipoDocumento,
                numeroDocumento: numeroDocumento,
                numeroCelular: numeroCelular,
            },
            factor: {
                factorId: factorId,
                nombre: factores
            }
    
          }
          
          const options = {
            method: "POST",            
            body: JSON.stringify(datosPaciente),
            headers: {
                "Content-Type": "application/json",
				"Accept": "application/json"
            }
        }
        
        
        fetch("https://tdsbotapi-v01.azurewebsites.net/api/Conversacion/Registro", options).then(resp =>{} )
           
 })
    
    