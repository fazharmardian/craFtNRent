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
                    <a class="nav-link nav-link-white" href="request.php">
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
                <h1 class="mt-4">Request View</h1>
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
                        Request Table
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>User</th>
                                    <th>Item</th>
                                    <th>Total Request</th>
                                    <th>Type</th>
                                    <th>Rent Id</th>
                                    <th>Request Date</th>
                                    <th>Status</th>
                                    <th>Return Date</th>
                                    <th>Accept</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $query = "SELECT 
                                r.*,
                                u.username,
                                i.name
                            FROM 
                                request r
                            JOIN 
                                user u ON r.id_user = u.id
                            JOIN 
                                item i ON r.id_item = i.id
                            WHERE 
                                r.status = 'pending'
                            ORDER BY 
                                r.id ASC;
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
                                        <td><?php echo $row['username']; ?></td>
                                        <td><?php echo $row['name']; ?></td>
                                        <td><?php echo $row['total_request']; ?></td>
                                        <td><?php echo $row['type']; ?></td>
                                        <td><?php echo $row['rent_id']; ?></td>
                                        <td><?php echo $row['request_date']; ?></td>
                                        <td><?php echo $row['status']; ?></td>
                                        <td><?php echo $row['return_date']; ?></td>
                                        <td>
                                            <a href="request.php?delete=<?php echo $row['id']; ?>" onclick="return confirm('Are you sure?')" class="btn btn-danger"><i class="fas fa-times"></i></a>
                                            <a href="request.php?approve=<?php echo $row['id']; ?>" class="btn btn-success"><i class="fas fa-check"></i></a>
                                        </td>
                                    </tr>
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
        
        <?php include 'layout/footer.php'; ?>
    </div>
</div>

<?php
if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $deleteQuery = "DELETE FROM request WHERE id='$id'";
    $deleteResult = mysqli_query($koneksi, $deleteQuery);

    if ($deleteResult) {
        echo "<script>alert('Request deleted successfully'); location.href='request.php';</script>";
    } else {
        echo "<script>alert('Failed to delete request');</script>";
    }
}

if (isset($_GET['approve'])) {
    $id = $_GET['approve'];
    $requestQuery = "SELECT * FROM request WHERE id='$id'";
    $requestResult = mysqli_query($koneksi, $requestQuery);

    if ($requestResult) {
        $requestData = mysqli_fetch_assoc($requestResult);

        $id_rent = $requestData['rent_id'];
        $id_user = $requestData['id_user'];
        $id_item = $requestData['id_item'];
        $total_request = $requestData['total_request'];
        $return_date = $requestData['return_date'];
        $type = $requestData['type'];

        $date = date('Y-m-d');

        $status = ($type == 'renting') ? 'lent' : 'returned';

        $rentQuery = ($type == 'renting') ? "INSERT INTO lending (status, return_date, lend_date, total_request, id_item, id_user) 
        VALUES ('$status', '$return_date', '$date', '$total_request', '$id_item', '$id_user')" :
        "UPDATE lending
        SET 
            actual_return_date = '$date', 
            status = '$status'
        WHERE 
            id = '$id_rent'; ";
        $rentResult = mysqli_query($koneksi, $rentQuery);

        if ($rentResult) {
            $statusQuery = "UPDATE request SET status='approved' WHERE id='$id'";
            $statusResult = mysqli_query($koneksi, $statusQuery);

            if ($statusResult) {
                if ($type == 'renting') {
                    $updateStockQuery = "UPDATE item SET stock = stock - $total_request WHERE id = $id_item";
                } else if ($type == 'returning') {
                    $updateStockQuery = "UPDATE item SET stock = stock + $total_request WHERE id = $id_item";
                }
                
                $stockResult = mysqli_query($koneksi, $updateStockQuery);

                if ($stockResult) {
                    echo "<script>alert('Request approved successfully'); location.href='request.php';</script>";
                } else {
                    echo "<script>alert('Failed to update stock');</script>";
                }
            } else {
                echo "<script>alert('Failed to update request status');</script>";
            }
        } else {
            echo "<script>alert('Failed to approve request');</script>";
        }
    } else {
        echo "<script>alert('Failed to fetch request data');</script>";
    }
}
?>
