<?php
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
    background-color: #3a3a3a;
    color: white;
}

.modal-body {
    background-color: #fff;
}

.modal-footer {
    background-color: #3a3a3a;
}

.modal-footer .btn-primary {
    background-color: #007BFF;
    border-color: #007BFF;
}

.modal-footer .btn-danger {
    background-color: #DC3545;
    border-color: #DC3545;
}

.modal-title {
    color: #ffffff;
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
                    <a class="nav-link" href="user.php">
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
                    <a class="nav-link nav-link-white" href="lending.php">
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
                <h1 class="mt-4">Lending View</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">
                        <div class="card-header">

                        </div>
                    </li>
                </ol>
                <div class="row"></div>
                <div class="row"></div>
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Lending Table
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>User</th>
                                    <th>Item</th>
                                    <th>Total Request</th>
                                    <th>Lending/Return Date</th>
                                    <th>Return Date</th>
                                    <th>Actual Return Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $query = "SELECT 
                                l.*,
                                u.username AS user_username,
                                i.name AS item_name
                            FROM 
                                lending l
                            JOIN 
                                user u ON l.id_user = u.id
                            JOIN 
                                item i ON l.id_item = i.id
                            ORDER BY 
                                l.id ASC;
                            ";
                                $result = mysqli_query($koneksi, $query);

                                if (!$result) {
                                    die("Query Error: " . mysqli_errno($koneksi) . " - " . mysqli_error($koneksi));
                                }

                                $no = 1;
                                while ($row = mysqli_fetch_assoc($result)) {
                                ?>
                                <tr>
                                    <td><?php echo $no; ?></td>
                                    <td><?php echo $row['user_username']; ?></td>
                                    <td><?php echo $row['item_name']; ?></td>
                                    <td><?php echo $row['total_request']; ?></td>
                                    <td><?php echo $row['lend_date']; ?></td>
                                    <td><?php echo $row['return_date']; ?></td>
                                    <td><?php echo $row['actual_return_date']; ?></td>
                                    <td><?php echo $row['status']; ?></td>
                                    <td>
                                        <a href="lending.php?deleteLending=<?php echo $row['id']; ?>" onclick="return confirm('Are you sure?')" class="btn btn-danger">Delete</a>
                                    </td>
                                </tr>

                                <!-- Modal for editing lending -->
                                <div class="modal fade" id="editLendingModal<?php echo $row['id']; ?>" tabindex="-1" aria-labelledby="editLendingModalLabel<?php echo $row['id']; ?>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editLendingModalLabel<?php echo $row['id']; ?>">Edit Lending</h5>
                                            </div>
                                            <div class="container">
                                                <div class="modal-body">
                                                    <form action="lending.php" method="post">
                                                        <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
                                                        <input type="text" name="id_user" value="<?php echo $row['id_user']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="text" name="id_item" value="<?php echo $row['id_item']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="text" name="total_request" value="<?php echo $row['total_request']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="date" name="lend_date" value="<?php echo $row['lend_date']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="date" name="return_date" value="<?php echo $row['return_date']; ?>" class="form-control" required>
                                                        <br>
                                                        <input type="date" name="actual_return_date" value="<?php echo $row['actual_return_date']; ?>" class="form-control">
                                                        <br>
                                                        <input type="text" name="status" value="<?php echo $row['status']; ?>" class="form-control" required>
                                                        <br>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary" name="updateLending">Update</button>
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
if (isset($_POST['addLending'])) {
    $id_user = $_POST['id_user'];
    $id_item = $_POST['id_item'];
    $total_request = $_POST['total_request'];
    $lend_date = $_POST['lend_date'];
    $return_date = $_POST['return_date'];
    $actual_return_date = $_POST['actual_return_date'];
    $status = $_POST['status'];

    $query = "INSERT INTO lending (id_user, id_item, total_request, lend_date, return_date, actual_return_date, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $koneksi->prepare($query);
    $stmt->bind_param("iiissss", $id_user, $id_item, $total_request, $lend_date, $return_date, $actual_return_date, $status);
    $result = $stmt->execute();

    if ($result) {
        echo "<script>alert('Data added successfully'); window.location='lending.php';</script>";
    } else {
        echo "<script>alert('Data addition failed'); window.location='lending.php';</script>";
    }
}

if (isset($_GET['deleteLending'])) {
    $id = $_GET['deleteLending'];

    $query = "DELETE FROM lending WHERE id = ?";
    $stmt = $koneksi->prepare($query);
    $stmt->bind_param("i", $id);
    $result = $stmt->execute();

    if ($result) {
        echo "<script>alert('Data deleted successfully'); window.location='lending.php';</script>";
    } else {
        echo "<script>alert('Data deletion failed'); window.location='lending.php';</script>";
    }
}

if (isset($_POST['updateLending'])) {
    $id = $_POST['id'];
    $id_user = $_POST['id_user'];
    $id_item = $_POST['id_item'];
    $total_request = $_POST['total_request'];
    $lend_date = $_POST['lend_date'];
    $return_date = $_POST['return_date'];
    $actual_return_date = $_POST['actual_return_date'];
    $status = $_POST['status'];

    $query = "UPDATE lending SET id_user = ?, id_item = ?, total_request = ?, lend_date = ?, return_date = ?, actual_return_date = ?, status = ? WHERE id = ?";
    $stmt = $koneksi->prepare($query);
    $stmt->bind_param("iiissssi", $id_user, $id_item, $total_request, $lend_date, $return_date, $actual_return_date, $status, $id);
    $result = $stmt->execute();

    if ($result) {
        echo "<script>alert('Data updated successfully'); window.location='lending.php';</script>";
    } else {
        echo "<script>alert('Data update failed'); window.location='lending.php';</script>";
    }
}
?>

