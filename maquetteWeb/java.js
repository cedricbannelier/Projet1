// window.alert("texte");

function controle(form1) {
var test = document.form1.input.value;
alert("Vous avez tapé : " + test);
}

function afficher(form2) {
var testin =document. form2.input.value;
document.form2.output.value=testin
} 

   // fonction pour modifier le contenu de t2
   function modifieTexte() {
     var t2 = document.getElementById("t2");
     t2.firstChild.nodeValue = "trois";    
   }
   // fonction pour ajouter un écouteur à t
   function load() { 
     var el = document.getElementById("t"); 
     el.addEventListener("click", modifieTexte, false); 
   } 