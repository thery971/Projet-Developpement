<?php

// m_function_name : fonction model
// c_function_name : fonction controleur (à faire)

// fonction d'inscription d'un client 
function m_inscription_client($nom , $prenom , $password_non_crypte ,  $email =  "" , $tel =  "" , $class_client ,  $pseudo ="" , $ville ){

        //connection à la base de donnée
        try
        {
            include_once("../config.php") ; 

            $bdd = new PDO('mysql:host=localhost;dbname='.constant("BD_NAME").';charset=utf8', constant("BD_USER") , constant("BD_MDP") );
        }
        catch (Exception $e)
        {
            die('Erreur : ' . $e->getMessage());
        }


        // On crypte le mot de passe
        $password = md5($password_non_crypte);

        $sql = "SELECT DISTINCT pseudocli  FROM client WHERE pseudocli = $pseudo";
       

        $count =  0 ; 
        foreach ($bdd->query($sql) as $row) {
            $count += 1 ;    
        }

        if ($count > 0) {
            
            return "ERREUR :  ce pseudo est déja pris" ; 
        }
 
        $sql = "INSERT INTO client(nomcli , prencli , telcli , mailcli , classcli , pseudocli , mdpcli) VALUES ($nom,$prenom,$tel,$email,$class_client ,$pseudo , $password)";
    
        // On envoie la requête
        
        $bdd->query($sql) ;
        
        
        return "OK :  tout c'est bien passe" ; 
        


}


/*
* la connexion se fait avec le pseudo
*/
function m_connexion_client($pseudo , $password_non_crypte ){

    //connection à la base de donnée
    try
    {  
    include_once("../config.php") ; 
    
        $bdd = new PDO('mysql:host=localhost;dbname='.constant("BD_NAME").';charset=utf8', constant("BD_USER") , constant("BD_MDP") );
    }
    catch (Exception $e)
    {
        die('Erreur : ' . $e->getMessage());
    }



    // On crypte le mot de passe
    $password = md5($password_non_crypte);


    // On crypte le mot de passe
    $password = md5($password_non_crypte);

    $sql =  "SELECT * FROM client WHERE pseudocli = $pseudo AND mdpcli = $password" ;

    $result  = $bdd->query($sql)->fetch() ;

    if($result){

    
        session_start();

        $_SESSION["id_client"] = $result["idcli"] ;
        $_SESSION["etat"]  = 1 ; 

        
    } else {

        return "ERREUR :  LA CONNEXION à ECHOUÉ" ; 


    }
    
    

}

// Fonction suppression de compte
function m_supprimer_compte($psudo){

    //ouvrir une connexion, tu remplaces par les accès
    $mysqli = new mysqli("localhost", "root", "", "client");
    
    //tester la connexion
    
       if (mysqli_connect_error()) {
    
           printf("Echec de la connexion : %s\n", mysqli_connect_error());
            exit();
       }
      // verification des données 
    
      $sql = "SELECT DISTINCT pseudocli , mailcli FROM client WHERE pseudocli = $psudo";
           
    
       $compt =  0 ; 
       foreach ($mysqli->query($sql) as $row) {
          $compt += 1 ;    
        }
    
        if ($compt > 0) {
          
          // effectuer l'operation
          $mysqli->query("Delete from client where pseudocli = "$psudo);
        }
       
        //fermer la connexion
    
        mysqli_close();
    
        //Redirection vers la page de connexion
    
        header("Location:login.php");
    
    }


// Modification des informations du compte
function m_modifier_compte(){
      
      if (isset($_POST['submitnom']))
      {
          include_once ("model.php");
          modification("nomcli", $_POST["nom"],1);
      }
  
      elseif (isset($_POST['submitprenom']))
      {
          include_once ("model.php");
          modification("prencli", $_POST["prenom"],1);
      }
  
      elseif (isset($_POST['submittel']))
      {
          include_once ("model.php");
          modification("telcli", $_POST["tel"],1);
      }
  
      elseif (isset($_POST['submitmail']))
      {
          include_once ("model.php");
          modification("mailcli", $_POST["mail"],1);
      }
  
      elseif (isset($_POST['submitpseudo']))
      {
          include_once ("model.php");
          modification("pseudocli", $_POST["pseudo"],1);
      }
  
      elseif (isset($_POST['submitmdp']))
      { 
          $_POST["mdp"] = password_hash($_POST["mdp"], PASSWORD_DEFAULT);
          include_once ("model.php");
          modification("mdpcli", $_POST["mdp"],1);
      }
  
      elseif (isset($_POST['submitcp']))
      {
          include_once ("model.php");
          modification("cp", $_POST["cp"],1);
      } 
}

// Fonction de déconnexion
function m_deconnexion(){

    unset($_SESSION["id_client"]);
    unset($_SESSION["etat"]);
    session_destroy();
    
    //Redirection vers la page de connexion
    header("Location:login.php");
}
