<a style="position:absolute;" href='/Superuser/Plantincharge/dashboard.php'>Back</a>

<h4 style="position: relative; left:95%;">
    <button onclick="myFunction()">Print</button>

<script>
    function myFunction() {
        window.print();
    }

</script>
</h4>
<h3 style="text-align:center; font-family: sans-serif; border-radius: 25px;
  border: 2px solid #73AD21;
  padding: 5px; 
  width: 200px;
  height: 25px;
  position:relative;
  left:500px; 
  overflow: hidden;">PROPOSAL No.</h3>

<?php
 ////////////////////////////////////////////
// Collecting data from query string
$id=$_GET['id'];
// Checking data it is a number or not
if(!is_numeric($id)){
echo "Data Error";
exit;
}
// MySQL connection string
    require "dbconfig.php"; 

$count="SELECT * FROM createnearmiss where id=?";

if($stmt = $connection->prepare($count)){
  $stmt->bind_param('i',$id);
  $stmt->execute();

 $result = $stmt->get_result();

 $row=$result->fetch_object();
 echo "<table>";
echo "

   <table>

<tr>
<th>Details :</th>
<td>$row->details</td>
  </tr>
  <tr>
    <th>Location :</th>
   <td>$row->location</td>
  </tr>
  <tr>
    <th>Date :</th>
   <td>$row->date</td>
  </tr>
  <tr>
    <th>Time :</th>
   <td>$row->time</td>
  </tr>
  <tr>
    <th>Checkbox :</th>
   <td>$row->checkbox</td>
  </tr>
  <tr>
    <th>Name :</th>
   <td>$row->name</td>
  </tr>
  <tr>
    <th>Employeeid :</th>
   <td>$row->employeeid</td>
  </tr>
  <tr>
    <th>Age :</th>
   <td>$row->age</td>
  </tr>
   <tr>
     <th>Department :</th>
    <td>$row->department</td>
   </tr>
   <tr>
     <th>Contact :</th>
    <td>$row->contact</td>
   </tr>
   <tr>
     <th>Organization :</th>
    <td>$row->organization</td>
   </tr>
   <tr>
     <th>Summary :</th>
    <td>$row->summary</td>
   </tr>
   <tr>
     <th>Images :</th>
    <td>$row->images</td>
   </tr>
   <tr>
     <th>Outcome :</th>
    <td>$row->outcome</td>
   </tr>
   <tr>
<th>Cause :</th>
       <td>$row->cause</td>
      </tr>
      <tr>
        <th>Action :</th>
       <td>$row->action</td>
      </tr>
      <tr>
        <th>Reportedby :</th>
       <td>$row->reportedbyname</td>
      </tr>
      <tr>
        <th>Position :</th>
       <td>$row->position</td>
      </tr>
      <tr>
        <th>Organisation :</th>
       <td>$row->reportedorganisation</td>
      </tr>
      <tr>
        <th>Reportedcontact :</th>
       <td>$row->reportedcontact</td>
      </tr>
      <tr>
        <th>Status :</th>
       <td>$row->status</td>
      </tr>
      </table>

    ";

    echo "</table>";
}else{
echo $connection->error;
}
?>        

 <style>
 table {
    width: 100%;
    font-family: arial, sans-serif;
    background-color: floralwhite;
    overflow: auto;
    flex: 1;
}

table,
th,
td {
    border: 1px solid orange;
    border-collapse: separate;
    overflow: auto;
}

th,
td {
    padding: 5px;
    text-align: left;
    overflow: auto;
}

</style>
<br><br>

<td><form method="post" action=""><textarea name="comment"></textarea></td>
<td>
 <button type="submit" name="approved" class="btn btn-primary">Approve</button>
 <button type="submit" name="rejected" class="btn btn-primary">Rejecte</button>
      </form></td>

<?php
include 'dbconfig.php';
if (isset($_POST['approved'])){
$status="Approved";
$comment=$_POST['comment'];

        $query = "UPDATE createnearmiss set status = $status, comment = '$comment'";

}

if (isset($_POST['rejected'])){
$status="Rejected";
$comment=$_POST['comment'];     

$query = "UPDATE createnearmiss set status = $status, comment = '$comment'";

}

?>

<br>
<a href='/Superuser/Plantincharge/dashboard.php'>Back</a>