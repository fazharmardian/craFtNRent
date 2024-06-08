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
                    <a class="nav-link nav-link-white" href="barang.php">
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
                <h1 class="mt-4">Item View</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">
                        <div class="card-header">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                            <div class="sb-nav-link-icon icon-out"><i class="fas fa-add"></i></div>
                            </button>

                            <!-- Modal for adding new goods -->
                            <form method="post" action="barang.php" enctype="multipart/form-data">
                                <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addModalLabel">Add More</h5>
                                            </div>
                                            <div class="container">
                                                <div class="modal-body">
                                                    <input type="text" name="nama" placeholder="Name" class="form-control" required>
                                                    <br>
                                                    <input type="file" name="gambar" placeholder="Image" class="form-control" required>
                                                    <br>
                                                    <input type="text" name="tipe" placeholder="Type" class="form-control" required>
                                                    <br>
                                                    <input type="text" name="merk" placeholder="Brand" class="form-control" required>
                                                    <br>
                                                    <input type="text" name="stok" placeholder="Stock" class="form-control" required>
                                                    <br>
                                                    <input type="text" name="status" placeholder="Status" class="form-control" required>
                                                    <br>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary" name="add">Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <?php
                            if (isset($_POST['add'])) {
                                $nama = $_POST['nama'];
                                $image = $_FILES['gambar']['name'];
                                $tipe = $_POST['tipe'];
                                $merk = $_POST['merk'];
                                $stok = $_POST['stok'];
                                $status = $_POST['status'];

                                if ($image != "") {
                                    $allowed_extensions = array('png', 'jpg');
                                    $x = explode('.', $image);
                                    $extension = strtolower(end($x));
                                    $file_tmp = $_FILES['gambar']['tmp_name'];
                                    $random_number = rand(1, 999);
                                    $new_image_name = $random_number . '-' . $image;

                                    if (in_array($extension, $allowed_extensions) === true) {
                                        move_uploaded_file($file_tmp, 'gambar/' . $new_image_name);

                                        $query = "INSERT INTO item (name, image, type, brand, stock, status) VALUES (?, ?, ?, ?, ?, ?)";
                                        $stmt = $koneksi->prepare($query);
                                        $stmt->bind_param("ssssss", $nama, $new_image_name, $tipe, $merk, $stok, $status);
                                        $result = $stmt->execute();

                                        if (!$result) {
                                            die("Query Error: " . $stmt->errno . " - " . $stmt->error);
                                        } else {
                                            echo "<script>
                                            Swal.fire({
                                                title: 'Success!',
                                                text: 'Data added successfully',
                                                icon: 'success',
                                                confirmButtonText: 'OK'
                                            }).then((result) => {
                                                if (result.isConfirmed) {
                                                    window.location = 'barang.php';
                                                }
                                            });
                                        </script>
                                        ";
                                        }
                                    } else {
                                        echo "<script>
                                        Swal.fire({
                                            title: 'Invalid File Extension',
                                            text: 'Extensions can only be png and jpg',
                                            icon: 'error',
                                            confirmButtonText: 'OK'
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                window.location = 'barang.php';
                                            }
                                        });
                                    </script>
                                    ";
                                    }
                                } else {
                                    echo "<script>
                                    Swal.fire({
                                        title: 'Invalid File Extension',
                                        text: 'Image Can't Be Empty',
                                        icon: 'error',
                                        confirmButtonText: 'OK'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location = 'barang.php';
                                        }
                                    });
                                </script>
                                ";
                                }
                            }

                            if (isset($_POST['update'])) {
                                $id_barang = $_POST['id'];
                                $nama = $_POST['nama'];
                                $gambar = $_FILES['gambar']['name'];
                                $tipe = $_POST['tipe'];
                                $merk = $_POST['merk'];
                                $stok = $_POST['stok'];
                                $status = $_POST['status'];

                                if ($gambar != "") {
                                    $allowed_extensions = array('png', 'jpg');
                                    $x = explode('.', $gambar);
                                    $extension = strtolower(end($x));
                                    $file_tmp = $_FILES['gambar']['tmp_name'];
                                    $random_number = rand(1, 999);
                                    $new_image_name = $random_number . '-' . $gambar;

                                    if (in_array($extension, $allowed_extensions) === true) {
                                        move_uploaded_file($file_tmp, 'gambar/' . $new_image_name);

                                        $query = "UPDATE item SET name=?, image=?, type=?, brand=?, stock=?, status=? WHERE id=?";
                                        $stmt = $koneksi->prepare($query);
                                        $stmt->bind_param("ssssssi", $nama, $new_image_name, $tipe, $merk, $stok, $status, $id_barang);
                                        $result = $stmt->execute();

                                        if (!$result) {
                                            die("Query Error: " . $stmt->errno . " - " . $stmt->error);
                                        } else {
                                            echo "<script>alert('Data updated successfully');window.location='barang.php';</script>";
                                        }
                                    } else {
                                        echo "<script>alert('Extensions can only be png and jpg');window.location='barang.php';</script>";
                                    }
                                } else {
                                    $query = "UPDATE item SET name=?, type=?, brand=?, stock=?, status=? WHERE id=?";
                                    $stmt = $koneksi->prepare($query);
                                    $stmt->bind_param("sssssi", $nama, $tipe, $merk, $stok, $status, $id_barang);
                                    $result = $stmt->execute();

                                    if (!$result) {
                                        die("Query Error: " . $stmt->errno . " - " . $stmt->error);
                                    } else {
                                        echo "<script>alert('Data updated successfully');window.location='barang.php';</script>";
                                    }
                                }
                            }

                            if (isset($_GET['delete'])) {
                                $id_barang = $_GET['delete'];

                                $query = "DELETE FROM item WHERE id=?";
                                $stmt = $koneksi->prepare($query);
                                $stmt->bind_param("i", $id_barang);
                                $result = $stmt->execute();

                                if (!$result) {
                                    die("Query Error: " . $stmt->errno . " - " . $stmt->error);
                                } else {
                                    echo "<script>alert('Data deleted successfully');window.location='barang.php';</script>";
                                }
                            }
                            ?>

                        </div>
                    </li>
                </ol>
                <div class="row">
                </div>
                <div class="row">
                </div>
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Item Table
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Name</th>
                                    <th>Type</th>
                                    <th>Brand</th>
                                    <th>Stock</th>
                                    <th>Status</th>
                                    <th>Image</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $query = "SELECT * FROM item ORDER BY id ASC";
                                $result = $koneksi->query($query);

                                if (!$result) {
                                    die("Query Error: " . $koneksi->errno . " - " . $koneksi->error);
                                }

                                $no = 1;
                                while ($row = $result->fetch_assoc()) {
                                ?>
                                    <tr>
                                        <td><?php echo $no; ?></td>
                                        <td><?php echo $row['name']; ?></td>
                                        <td><?php echo $row['type']; ?></td>
                                        <td><?php echo $row['brand']; ?></td>
                                        <td><?php echo $row['stock']; ?></td>
                                        <td><?php echo $row['status']; ?></td>
                                        <td>
                                            <img src="gambar/<?php echo $row['image']; ?>" alt="<?php echo $row['name']; ?>" class="product-image" width="50">
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editModal<?php echo $row['id']; ?>">Edit</button>
                                            <a href="barang.php?delete=<?php echo $row['id']; ?>" onclick="return confirm('Are you sure?')" class="btn btn-danger">Delete</a>
                                        </td>
                                    </tr>

                                    <!-- Modal for editing goods -->
                                    <div class="modal fade" id="editModal<?php echo $row['id']; ?>" tabindex="-1" aria-labelledby="editModalLabel<?php echo $row['id']; ?>" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="editModalLabel<?php echo $row['id']; ?>">Edit Goods</h5>
                                                </div>
                                                <form method="post" action="barang.php" enctype="multipart/form-data">
                                                    <div class="container">
                                                        <div class="modal-body">
                                                            <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
                                                            <input type="text" name="nama" value="<?php echo $row['name']; ?>" class="form-control" required>
                                                            <br>
                                                            <input type="file" name="gambar" class="form-control">
                                                            <br>
                                                            <input type="text" name="tipe" value="<?php echo $row['type']; ?>" class="form-control" required>
                                                            <br>
                                                            <input type="text" name="merk" value="<?php echo $row['brand']; ?>" class="form-control" required>
                                                            <br>
                                                            <input type="text" name="stok" value="<?php echo $row['stock']; ?>" class="form-control" required>
                                                            <br>
                                                            <input type="text" name="status" value="<?php echo $row['status']; ?>" class="form-control" required>
                                                            <br>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary" name="update">Update</button>
                                                    </div>
                                                </form>
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
