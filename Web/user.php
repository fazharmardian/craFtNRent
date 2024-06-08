<?php
include 'cek_session.php';
include 'layout/header.php';
include 'koneksi.php';

session_start();

if(!isset($_SESSION['user_id'])) {
    echo "<script>document.location.href = 'index.php';</script>";
    exit;
}
?>
<style>
.modal-header {
    background-color: #3a3a3a; /* Example color */
    color: white;
}

.modal-body {
    background-color: #fff; /* Example color */
}

.modal-footer {
    background-color: #3a3a3a; /* Example color */
}

.modal-footer .btn-primary {
    background-color: #007BFF; /* Example color */
    border-color: #007BFF; /* Example color */
}

.modal-footer .btn-danger {
    background-color: #DC3545; /* Example color */
    border-color: #DC3545; /* Example color */
}

.modal-title {
    color: #ffffff; /* Example color */
}
.nav-link-white {
    color: white !important;
}

.nav-link-white .sb-nav-link-icon i {
    color: white !important;
}

.nav-link-red {
        color: red !important;
    }

    .nav-link-red .icon-out {
        color: red !important;
    }
</style>

<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">MENU</div>
                    <a class="nav-link nav-link-white" href="user.php">
                        <div class="sb-nav-link-icon"><i class="fas fa-user"></i></div>
                        User
                    </a>
                    <a class="nav-link" href="barang.php">
                        <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                        Item
                    </a>
                    <a class="nav-link" href="request.php">
                        <div class="sb-nav-link-icon"><i class="fas fa-tasks"></i></div>
                        Request
                    </a>
                    <a class="nav-link" href="lending.php">
                        <div class="sb-nav-link-icon"><i class="fas fa-handshake"></i></div>
                        Lending
                    </a>
                    <a class="nav-link nav-link-red" href="logout.php">
                        <div class="sb-nav-link-icon icon-out"><i class="fas fa-sign-out-alt"></i></div>
                        Log Out
                    </a>
                </div>
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">User View</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">
                        <div class="card-header">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                            <div class="sb-nav-link-icon icon-out"><i class="fas fa-add"></i></div>
                            </button>

                            <!-- Modal for adding new user -->
                            <form action="user.php" method="post">
                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Add More</h5>
                                            </div>
                                            <div class="container">
                                                <div class="modal-body">
                                                    <input type="text" name="username" placeholder="Username" class="form-control" required>
                                                    <br>
                                                    <input type="email" name="email" placeholder="Email" class="form-control" required>
                                                    <br>
                                                    <input type="text" name="telephone" placeholder="Telephone" class="form-control" required>
                                                    <br>
                                                    <input type="password" name="password" placeholder="Password" class="form-control" required>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary" name="go">Go!</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </li>
                </ol>
                <div class="row"></div>
                <div class="row"></div>
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        User Table
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Telephone</th>
                                    <th>Password</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $query = "SELECT * FROM user ORDER BY id ASC";
                                $result = mysqli_query($koneksi, $query);

                                if (!$result) {
                                    die("Query Error: " . mysqli_errno($koneksi) . " - " . mysqli_error($koneksi));
                                }

                                $no = 1;
                                while ($row = mysqli_fetch_assoc($result)) {
                                ?>
                                <tr>
                                    <td><?php echo $no; ?></td>
                                    <td><?php echo $row['username']; ?></td>
                                    <td><?php echo $row['email']; ?></td>
                                    <td><?php echo $row['telephone']; ?></td>
                                    <td><?php echo $row['password']; ?></td>
                                    <td>
                                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editModal<?php echo $row['id']; ?>">Edit</button>
                                        <a href="user.php?delete=<?php echo $row['id']; ?>" onclick="return confirm('Are you sure?')" class="btn btn-danger">Delete</a>
                                    </td>
                                </tr>

                                <!-- Modal for editing user -->
                                <div class="modal fade" id="editModal<?php echo $row['id']; ?>" tabindex="-1" aria-labelledby="editModalLabel<?php echo $row['id']; ?>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editModalLabel<?php echo $row['id']; ?>">Edit User</h5>
                                            </div>
                                            <div class="container">
                                                <div class="modal-body">
                                                    <form action="user.php" method="post">
                                                        <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
                                                        <input type="text" name="username" value="<?php echo $row['username']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="email" name="email" value="<?php echo $row['email']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="text" name="telephone" value="<?php echo $row['telephone']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="password" name="password" placeholder="New Password" class="form-control">
                                                        <br>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary" name="update">Update</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <?php
                                    $no++;
                                }
                                ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
        <?php
        include 'layout/footer.php';
        ?>
    </div>
</div>

<?php
if (isset($_POST['go'])) {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $telephone = $_POST['telephone'];
    $password = $_POST['password'];

    $query = "INSERT INTO user (username, email, telephone, password) VALUES ('$username', '$email', '$telephone', '$password')";
    $result = mysqli_query($koneksi, $query);

    if ($result) {
        echo "<script>alert('Data added successfully'); window.location='user.php';</script>";
    } else {
        echo "<script>alert('Data addition failed'); window.location='user.php';</script>";
    }
}

if (isset($_GET['delete'])) {
    $id = $_GET['delete'];

    $query = "DELETE FROM user WHERE id = '$id'";
    $result = mysqli_query($koneksi, $query);

    if ($result) {
        echo "<script>alert('Data deleted successfully'); window.location='user.php';</script>";
    } else {
        echo "<script>alert('Data deletion failed'); window.location='user.php';</script>";
    }
}

if (isset($_POST['update'])) {
    $id = $_POST['id'];
    $username = $_POST['username'];
    $email     = $_POST['email'];
    $telephone = $_POST['telephone'];
    $password = $_POST['password'];

    if (!empty($password)) {
        $query = "UPDATE user SET username='$username', email='$email', telephone='$telephone', password='$password' WHERE id='$id'";
    } else {
        $query = "UPDATE user SET username='$username', email='$email', telephone='$telephone' WHERE id='$id'";
    }

    $result = mysqli_query($koneksi, $query);

    if ($result) {
        echo "<script>alert('Data updated successfully'); window.location='user.php';</script>";
    } else {
        echo "<script>alert('Data update failed'); window.location='user.php';</script>";
    }
}
?>

