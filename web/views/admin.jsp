<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <style>
        body { background:#f4f6f9; font-family: Arial, sans-serif; }

        /* Nút mở sidebar */
        .open-btn {
            font-size: 20px;
            cursor: pointer;
            background: #0d6efd;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            margin:10px;
        }

        /* Main */
        main{ padding:80px 20px 24px; transition: margin-left .3s; }

        .card{ border:none; border-radius:14px; box-shadow:0 6px 18px rgba(0,0,0,.06); }
        .kpi .card{ transition:.2s; }
        .kpi .card:hover{ transform:translateY(-2px); box-shadow:0 10px 20px rgba(0,0,0,.08); }

        .muted{ color:#6c757d; font-size:12px; }
        .best-item img{ width:100%; height:160px; object-fit:cover; border-radius:10px; }
        .best-item h6{ margin:8px 0 4px; }
    </style>
</head>
<body>

<button class="open-btn" onclick="openSidebar()">☰ Menu</button>

<jsp:include page="/inc/sidebar.jsp"/>

<main>
    <div class="container-fluid">
        <h2 class="fw-bold mb-4">Tổng quan</h2>

        <div class="row g-3 kpi">
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-secondary small">Visits</div>
                            <div class="fs-4 fw-bold">32,451</div>
                            <div class="muted">+4.04% tuần trước</div>
                        </div>
                        <span class="badge bg-primary">Live</span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card p-3">
                    <div class="text-secondary small">Impressions</div>
                    <div class="fs-4 fw-bold">15,236</div>
                    <div class="muted">+3.87% tuần trước</div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card p-3">
                    <div class="text-secondary small">Conversion</div>
                    <div class="fs-4 fw-bold">7,688</div>
                    <div class="muted">+2.46% tuần trước</div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card p-3">
                    <div class="text-secondary small">Downloads</div>
                    <div class="fs-4 fw-bold">1,553</div>
                    <div class="muted">+0.74% tuần trước</div>
                </div>
            </div>
        </div>

        <div class="row g-3 mt-1">
            <div class="col-12 col-lg-8">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5 class="mb-0">Sales & Revenue Overview</h5>
                        <div class="text-secondary small">1D • 5D • 1M • 1Y</div>
                    </div>
                    <canvas id="lineChart" height="110"></canvas>
                    <div class="row mt-3 text-center">
                        <div class="col">
                            <div class="text-secondary small">Total Cost</div>
                            <div class="fw-bold">15,263 ₫</div>
                        </div>
                        <div class="col">
                            <div class="text-secondary small">Total Revenue</div>
                            <div class="fw-bold">753,098 ₫</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-4">
                <div class="card p-4 h-100">
                    <h5 class="mb-3">Net Profit Margin</h5>
                    <canvas id="radarChart" height="240"></canvas>
                </div>
            </div>
        </div>

        <div class="row g-3 mt-4">
            <div class="col-12">
                <h5 class="fw-bold mb-2">Best Seller</h5>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card p-3 best-item">
                    <img src="assets/images/Guppy Full Red.png" alt="Guppy Full Red">
                    <h6>Guppy Full Red</h6>
                    <div class="text-secondary small">Bán chạy #1</div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card p-3 best-item">
                    <img src="assets/images/Tôm Blue Dream.png" alt="Tôm Blue Dream">
                    <h6>Tôm Blue Dream</h6>
                    <div class="text-secondary small">Bán chạy #2</div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card p-3 best-item">
                    <img src="assets/images/Guppy Lace.png" alt="Guppy Lace">
                    <h6>Guppy Lace</h6>
                    <div class="text-secondary small">Bán chạy #3</div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card p-3 best-item">
                    <img src="assets/images/Betta Plakat (PK).webp" alt="Betta Plakat (PK)">
                    <h6>Betta Plakat (PK)</h6>
                    <div class="text-secondary small">Bán chạy #4</div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    /* ===== Line Chart: Sales + Revenue ===== */
    const ctxLine = document.getElementById('lineChart').getContext('2d');
    new Chart(ctxLine, {
        type: 'line',
        data: {
            labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug'],
            datasets: [
                {
                    label: 'Sales',
                    data: [50, 70, 60, 95, 120, 110, 140, 165],
                    borderColor: '#0d6efd',
                    backgroundColor: 'rgba(13,110,253,.18)',
                    fill: true,
                    tension: .4,
                    pointRadius: 3
                },
                {
                    label: 'Revenue',
                    data: [80, 100, 95, 130, 150, 170, 190, 210],
                    borderColor: '#198754',
                    backgroundColor: 'rgba(25,135,84,.18)',
                    fill: true,
                    tension: .4,
                    pointRadius: 3
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' },
                tooltip: {
                    callbacks: {
                        label: (ctx) => ctx.dataset.label + ': ' +
                            Number(ctx.raw).toLocaleString('vi-VN') + ' ₫'
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: (v) => Number(v).toLocaleString('vi-VN') + ' ₫'
                    }
                }
            }
        }
    });

    /* ===== Radar Chart: Sales vs Orders ===== */
    const ctxRadar = document.getElementById('radarChart').getContext('2d');
    new Chart(ctxRadar, {
        type: 'radar',
        data: {
            labels: ['Jan','Feb','Mar','Apr','May','Jun'],
            datasets: [
                {
                    label: 'Sales',
                    data: [65, 59, 90, 81, 56, 55],
                    backgroundColor: 'rgba(13,110,253,.18)',
                    borderColor: '#0d6efd',
                    pointBackgroundColor: '#0d6efd'
                },
                {
                    label: 'Orders',
                    data: [28, 48, 40, 19, 96, 27],
                    backgroundColor: 'rgba(255,193,7,.2)',
                    borderColor: '#ffc107',
                    pointBackgroundColor: '#ffc107'
                }
            ]
        },
        options: {
            responsive: true,
            plugins: { legend: { position: 'top' } },
            scales: { r: { beginAtZero: true } }
        }
    });
</script>

</body>
</html>