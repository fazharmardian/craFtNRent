<?php
// include 'cek_session.php'; // Jika Anda memiliki file untuk mengecek sesi, aktifkan sesuai kebutuhan
include 'koneksi.php';

// Pastikan ada parameter action dan id yang dikirimkan
if (isset($_GET['action']) && isset($_GET['id'])) {
    $action = $_GET['action'];
    $id = $_GET['id'];

    // Proses berdasarkan tindakan yang dipilih
    switch ($action) {
        case 'approve':
            $status = 'Approved';
            break;
        case 'reject':
            $status = 'Rejected';
            break;
        default:
            // Tindakan tidak valid
            exit("Invalid Action");
    }

    // Update status permintaan di database
    $updateQuery = "UPDATE request SET status = '$status' WHERE id = $id";
    $result = mysqli_query($koneksi, $updateQuery);

    if ($result) {
        // Redirect kembali ke halaman request setelah pembaruan berhasil
        header("Location: request.php");
        exit();
    } else {
        // Penanganan kesalahan jika gagal memperbarui status
        die("Error updating request status: " . mysqli_error($koneksi));
    }
} else {
    // Jika parameter action atau id tidak tersedia, tampilkan pesan kesalahan
    exit("Invalid Parameters");
}
?>
