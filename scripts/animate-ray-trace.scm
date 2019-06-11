(define (load-frames filenames)
  (let* ((head (car filenames))
         (tail (cdr filenames))
         (image (car (gimp-file-load RUN-NONINTERACTIVE head head))))
    (map (lambda (filename) (load-frame filename image)) tail)
    image))

(define (load-frame filename image)
    (let* ((drawable (car (gimp-file-load-layer RUN-NONINTERACTIVE image filename))))
      (print filename)
      (gimp-image-insert-layer image drawable 0 0)))

(define (optimize image)
  (let ((drawable (car (gimp-image-get-active-drawable image))))
    (plug-in-animationoptimize RUN-NONINTERACTIVE image drawable)))

(define (convert-colors image)
  (gimp-image-convert-indexed image 1 0 256 0 1 ""))

(define (save image name)
  (let ((drawable (car (gimp-image-get-active-drawable image))))
    (file-gif-save RUN-NONINTERACTIVE image drawable name name 0 1 10 1)))

(define (create-gif name filenames)
  (print "loading...")
  (let* ((image (load-frames filenames)))
    (print "optimizing...")
    (optimize image)
    (print "converting...")
    (convert-colors image)
    (print "saving...")
    (save image name)
    (gimp-image-delete image)))

(create-gif  "ani.gif" '("ani/f-0000000000.ppm" "ani/f-0000000001.ppm" "ani/f-0000000002.ppm" "ani/f-0000000003.ppm" "ani/f-0000000004.ppm" "ani/f-0000000005.ppm" "ani/f-0000000006.ppm" "ani/f-0000000007.ppm" "ani/f-0000000008.ppm" "ani/f-0000000009.ppm" "ani/f-0000000010.ppm" "ani/f-0000000011.ppm" "ani/f-0000000012.ppm" "ani/f-0000000013.ppm" "ani/f-0000000014.ppm" "ani/f-0000000015.ppm" "ani/f-0000000016.ppm" "ani/f-0000000017.ppm" "ani/f-0000000018.ppm" "ani/f-0000000019.ppm" "ani/f-0000000020.ppm" "ani/f-0000000021.ppm" "ani/f-0000000022.ppm" "ani/f-0000000023.ppm" "ani/f-0000000024.ppm" "ani/f-0000000025.ppm" "ani/f-0000000026.ppm" "ani/f-0000000027.ppm" "ani/f-0000000028.ppm" "ani/f-0000000029.ppm" "ani/f-0000000030.ppm" "ani/f-0000000031.ppm" "ani/f-0000000032.ppm" "ani/f-0000000033.ppm" "ani/f-0000000034.ppm" "ani/f-0000000035.ppm" "ani/f-0000000036.ppm" "ani/f-0000000037.ppm" "ani/f-0000000038.ppm" "ani/f-0000000039.ppm" "ani/f-0000000040.ppm" "ani/f-0000000041.ppm" "ani/f-0000000042.ppm" "ani/f-0000000043.ppm" "ani/f-0000000044.ppm" "ani/f-0000000045.ppm" "ani/f-0000000046.ppm" "ani/f-0000000047.ppm" "ani/f-0000000048.ppm" "ani/f-0000000049.ppm" "ani/f-0000000050.ppm" "ani/f-0000000051.ppm" "ani/f-0000000052.ppm" "ani/f-0000000053.ppm" "ani/f-0000000054.ppm" "ani/f-0000000055.ppm" "ani/f-0000000056.ppm" "ani/f-0000000057.ppm" "ani/f-0000000058.ppm" "ani/f-0000000059.ppm" "ani/f-0000000060.ppm" "ani/f-0000000061.ppm" "ani/f-0000000062.ppm" "ani/f-0000000063.ppm" "ani/f-0000000064.ppm" "ani/f-0000000065.ppm" "ani/f-0000000066.ppm" "ani/f-0000000067.ppm" "ani/f-0000000068.ppm" "ani/f-0000000069.ppm" "ani/f-0000000070.ppm" "ani/f-0000000071.ppm" "ani/f-0000000072.ppm" "ani/f-0000000073.ppm" "ani/f-0000000074.ppm" "ani/f-0000000075.ppm" "ani/f-0000000076.ppm" "ani/f-0000000077.ppm" "ani/f-0000000078.ppm" "ani/f-0000000079.ppm" "ani/f-0000000080.ppm" "ani/f-0000000081.ppm" "ani/f-0000000082.ppm" "ani/f-0000000083.ppm" "ani/f-0000000084.ppm" "ani/f-0000000085.ppm" "ani/f-0000000086.ppm" "ani/f-0000000087.ppm" "ani/f-0000000088.ppm" "ani/f-0000000089.ppm" "ani/f-0000000090.ppm" "ani/f-0000000091.ppm" "ani/f-0000000092.ppm" "ani/f-0000000093.ppm" "ani/f-0000000094.ppm" "ani/f-0000000095.ppm" "ani/f-0000000096.ppm" "ani/f-0000000097.ppm" "ani/f-0000000098.ppm" "ani/f-0000000099.ppm" "ani/f-0000000100.ppm" "ani/f-0000000101.ppm" "ani/f-0000000102.ppm" "ani/f-0000000103.ppm" "ani/f-0000000104.ppm" "ani/f-0000000105.ppm" "ani/f-0000000106.ppm" "ani/f-0000000107.ppm" "ani/f-0000000108.ppm" "ani/f-0000000109.ppm" "ani/f-0000000110.ppm" "ani/f-0000000111.ppm" "ani/f-0000000112.ppm" "ani/f-0000000113.ppm" "ani/f-0000000114.ppm" "ani/f-0000000115.ppm" "ani/f-0000000116.ppm" "ani/f-0000000117.ppm" "ani/f-0000000118.ppm" "ani/f-0000000119.ppm" "ani/f-0000000120.ppm" "ani/f-0000000121.ppm" "ani/f-0000000122.ppm" "ani/f-0000000123.ppm" "ani/f-0000000124.ppm" "ani/f-0000000125.ppm" "ani/f-0000000126.ppm" "ani/f-0000000127.ppm" "ani/f-0000000128.ppm" "ani/f-0000000129.ppm" "ani/f-0000000130.ppm" "ani/f-0000000131.ppm" "ani/f-0000000132.ppm" "ani/f-0000000133.ppm" "ani/f-0000000134.ppm" "ani/f-0000000135.ppm" "ani/f-0000000136.ppm" "ani/f-0000000137.ppm" "ani/f-0000000138.ppm" "ani/f-0000000139.ppm" "ani/f-0000000140.ppm" "ani/f-0000000141.ppm" "ani/f-0000000142.ppm" "ani/f-0000000143.ppm" "ani/f-0000000144.ppm" "ani/f-0000000145.ppm" "ani/f-0000000146.ppm" "ani/f-0000000147.ppm" "ani/f-0000000148.ppm" "ani/f-0000000149.ppm" "ani/f-0000000150.ppm" "ani/f-0000000151.ppm" "ani/f-0000000152.ppm" "ani/f-0000000153.ppm" "ani/f-0000000154.ppm" "ani/f-0000000155.ppm" "ani/f-0000000156.ppm" "ani/f-0000000157.ppm" "ani/f-0000000158.ppm" "ani/f-0000000159.ppm" "ani/f-0000000160.ppm" "ani/f-0000000161.ppm" "ani/f-0000000162.ppm" "ani/f-0000000163.ppm" "ani/f-0000000164.ppm" "ani/f-0000000165.ppm" "ani/f-0000000166.ppm" "ani/f-0000000167.ppm" "ani/f-0000000168.ppm" "ani/f-0000000169.ppm" "ani/f-0000000170.ppm" "ani/f-0000000171.ppm" "ani/f-0000000172.ppm" "ani/f-0000000173.ppm" "ani/f-0000000174.ppm" "ani/f-0000000175.ppm" "ani/f-0000000176.ppm" "ani/f-0000000177.ppm" "ani/f-0000000178.ppm" "ani/f-0000000179.ppm" "ani/f-0000000180.ppm" "ani/f-0000000181.ppm" "ani/f-0000000182.ppm" "ani/f-0000000183.ppm" "ani/f-0000000184.ppm" "ani/f-0000000185.ppm" "ani/f-0000000186.ppm" "ani/f-0000000187.ppm" "ani/f-0000000188.ppm" "ani/f-0000000189.ppm" "ani/f-0000000190.ppm" "ani/f-0000000191.ppm" "ani/f-0000000192.ppm" "ani/f-0000000193.ppm" "ani/f-0000000194.ppm" "ani/f-0000000195.ppm" "ani/f-0000000196.ppm" "ani/f-0000000197.ppm" "ani/f-0000000198.ppm" "ani/f-0000000199.ppm" "ani/f-0000000200.ppm" "ani/f-0000000201.ppm" "ani/f-0000000202.ppm" "ani/f-0000000203.ppm" "ani/f-0000000204.ppm" "ani/f-0000000205.ppm" "ani/f-0000000206.ppm" "ani/f-0000000207.ppm" "ani/f-0000000208.ppm" "ani/f-0000000209.ppm" "ani/f-0000000210.ppm" "ani/f-0000000211.ppm" "ani/f-0000000212.ppm" "ani/f-0000000213.ppm" "ani/f-0000000214.ppm" "ani/f-0000000215.ppm" "ani/f-0000000216.ppm" "ani/f-0000000217.ppm" "ani/f-0000000218.ppm" "ani/f-0000000219.ppm" "ani/f-0000000220.ppm" "ani/f-0000000221.ppm" "ani/f-0000000222.ppm" "ani/f-0000000223.ppm" "ani/f-0000000224.ppm" "ani/f-0000000225.ppm" "ani/f-0000000226.ppm" "ani/f-0000000227.ppm" "ani/f-0000000228.ppm" "ani/f-0000000229.ppm" "ani/f-0000000230.ppm" "ani/f-0000000231.ppm" "ani/f-0000000232.ppm" "ani/f-0000000233.ppm" "ani/f-0000000234.ppm" "ani/f-0000000235.ppm" "ani/f-0000000236.ppm" "ani/f-0000000237.ppm" "ani/f-0000000238.ppm" "ani/f-0000000239.ppm" "ani/f-0000000240.ppm" "ani/f-0000000241.ppm" "ani/f-0000000242.ppm" "ani/f-0000000243.ppm" "ani/f-0000000244.ppm" "ani/f-0000000245.ppm" "ani/f-0000000246.ppm" "ani/f-0000000247.ppm" "ani/f-0000000248.ppm" "ani/f-0000000249.ppm" "ani/f-0000000250.ppm" "ani/f-0000000251.ppm" "ani/f-0000000252.ppm" "ani/f-0000000253.ppm" "ani/f-0000000254.ppm" "ani/f-0000000255.ppm" "ani/f-0000000256.ppm" "ani/f-0000000257.ppm" "ani/f-0000000258.ppm" "ani/f-0000000259.ppm" "ani/f-0000000260.ppm" "ani/f-0000000261.ppm" "ani/f-0000000262.ppm" "ani/f-0000000263.ppm" "ani/f-0000000264.ppm" "ani/f-0000000265.ppm" "ani/f-0000000266.ppm" "ani/f-0000000267.ppm" "ani/f-0000000268.ppm" "ani/f-0000000269.ppm" "ani/f-0000000270.ppm" "ani/f-0000000271.ppm" "ani/f-0000000272.ppm" "ani/f-0000000273.ppm" "ani/f-0000000274.ppm" "ani/f-0000000275.ppm" "ani/f-0000000276.ppm" "ani/f-0000000277.ppm" "ani/f-0000000278.ppm" "ani/f-0000000279.ppm" "ani/f-0000000280.ppm" "ani/f-0000000281.ppm" "ani/f-0000000282.ppm" "ani/f-0000000283.ppm" "ani/f-0000000284.ppm" "ani/f-0000000285.ppm" "ani/f-0000000286.ppm" "ani/f-0000000287.ppm" "ani/f-0000000288.ppm" "ani/f-0000000289.ppm" "ani/f-0000000290.ppm" "ani/f-0000000291.ppm" "ani/f-0000000292.ppm" "ani/f-0000000293.ppm" "ani/f-0000000294.ppm" "ani/f-0000000295.ppm" "ani/f-0000000296.ppm" "ani/f-0000000297.ppm" "ani/f-0000000298.ppm" "ani/f-0000000299.ppm" "ani/f-0000000300.ppm" "ani/f-0000000301.ppm" "ani/f-0000000302.ppm" "ani/f-0000000303.ppm" "ani/f-0000000304.ppm" "ani/f-0000000305.ppm" "ani/f-0000000306.ppm" "ani/f-0000000307.ppm" "ani/f-0000000308.ppm" "ani/f-0000000309.ppm" "ani/f-0000000310.ppm" "ani/f-0000000311.ppm" "ani/f-0000000312.ppm" "ani/f-0000000313.ppm" "ani/f-0000000314.ppm" "ani/f-0000000315.ppm" "ani/f-0000000316.ppm" "ani/f-0000000317.ppm" "ani/f-0000000318.ppm" "ani/f-0000000319.ppm" "ani/f-0000000320.ppm" "ani/f-0000000321.ppm" "ani/f-0000000322.ppm" "ani/f-0000000323.ppm" "ani/f-0000000324.ppm" "ani/f-0000000325.ppm" "ani/f-0000000326.ppm" "ani/f-0000000327.ppm" "ani/f-0000000328.ppm" "ani/f-0000000329.ppm" "ani/f-0000000330.ppm" "ani/f-0000000331.ppm" "ani/f-0000000332.ppm" "ani/f-0000000333.ppm" "ani/f-0000000334.ppm" "ani/f-0000000335.ppm" "ani/f-0000000336.ppm" "ani/f-0000000337.ppm" "ani/f-0000000338.ppm" "ani/f-0000000339.ppm" "ani/f-0000000340.ppm" "ani/f-0000000341.ppm" "ani/f-0000000342.ppm" "ani/f-0000000343.ppm" "ani/f-0000000344.ppm" "ani/f-0000000345.ppm" "ani/f-0000000346.ppm" "ani/f-0000000347.ppm" "ani/f-0000000348.ppm" "ani/f-0000000349.ppm" "ani/f-0000000350.ppm" "ani/f-0000000351.ppm" "ani/f-0000000352.ppm" "ani/f-0000000353.ppm" "ani/f-0000000354.ppm" "ani/f-0000000355.ppm" "ani/f-0000000356.ppm" "ani/f-0000000357.ppm" "ani/f-0000000358.ppm" "ani/f-0000000359.ppm" "ani/f-0000000360.ppm" "ani/f-0000000361.ppm" "ani/f-0000000362.ppm" "ani/f-0000000363.ppm" "ani/f-0000000364.ppm" "ani/f-0000000365.ppm" "ani/f-0000000366.ppm" "ani/f-0000000367.ppm" "ani/f-0000000368.ppm" "ani/f-0000000369.ppm" "ani/f-0000000370.ppm" "ani/f-0000000371.ppm" "ani/f-0000000372.ppm" "ani/f-0000000373.ppm" "ani/f-0000000374.ppm" "ani/f-0000000375.ppm" "ani/f-0000000376.ppm" "ani/f-0000000377.ppm" "ani/f-0000000378.ppm" "ani/f-0000000379.ppm" "ani/f-0000000380.ppm" "ani/f-0000000381.ppm" "ani/f-0000000382.ppm" "ani/f-0000000383.ppm" "ani/f-0000000384.ppm" "ani/f-0000000385.ppm" "ani/f-0000000386.ppm" "ani/f-0000000387.ppm" "ani/f-0000000388.ppm" "ani/f-0000000389.ppm" "ani/f-0000000390.ppm" "ani/f-0000000391.ppm" "ani/f-0000000392.ppm" "ani/f-0000000393.ppm" "ani/f-0000000394.ppm" "ani/f-0000000395.ppm" "ani/f-0000000396.ppm" "ani/f-0000000397.ppm" "ani/f-0000000398.ppm" "ani/f-0000000399.ppm" "ani/f-0000000400.ppm" "ani/f-0000000401.ppm" "ani/f-0000000402.ppm" "ani/f-0000000403.ppm" "ani/f-0000000404.ppm" "ani/f-0000000405.ppm" "ani/f-0000000406.ppm" "ani/f-0000000407.ppm" "ani/f-0000000408.ppm" "ani/f-0000000409.ppm" "ani/f-0000000410.ppm" "ani/f-0000000411.ppm" "ani/f-0000000412.ppm" "ani/f-0000000413.ppm" "ani/f-0000000414.ppm" "ani/f-0000000415.ppm" "ani/f-0000000416.ppm" "ani/f-0000000417.ppm" "ani/f-0000000418.ppm" "ani/f-0000000419.ppm" "ani/f-0000000420.ppm" "ani/f-0000000421.ppm" "ani/f-0000000422.ppm" "ani/f-0000000423.ppm" "ani/f-0000000424.ppm" "ani/f-0000000425.ppm" "ani/f-0000000426.ppm" "ani/f-0000000427.ppm" "ani/f-0000000428.ppm" "ani/f-0000000429.ppm" "ani/f-0000000430.ppm" "ani/f-0000000431.ppm" "ani/f-0000000432.ppm" "ani/f-0000000433.ppm" "ani/f-0000000434.ppm" "ani/f-0000000435.ppm" "ani/f-0000000436.ppm" "ani/f-0000000437.ppm" "ani/f-0000000438.ppm" "ani/f-0000000439.ppm" "ani/f-0000000440.ppm" "ani/f-0000000441.ppm" "ani/f-0000000442.ppm" "ani/f-0000000443.ppm" "ani/f-0000000444.ppm" "ani/f-0000000445.ppm" "ani/f-0000000446.ppm" "ani/f-0000000447.ppm" "ani/f-0000000448.ppm" "ani/f-0000000449.ppm" "ani/f-0000000450.ppm" "ani/f-0000000451.ppm" "ani/f-0000000452.ppm" "ani/f-0000000453.ppm" "ani/f-0000000454.ppm" "ani/f-0000000455.ppm" "ani/f-0000000456.ppm" "ani/f-0000000457.ppm" "ani/f-0000000458.ppm" "ani/f-0000000459.ppm" "ani/f-0000000460.ppm" "ani/f-0000000461.ppm" "ani/f-0000000462.ppm" "ani/f-0000000463.ppm" "ani/f-0000000464.ppm" "ani/f-0000000465.ppm" "ani/f-0000000466.ppm" "ani/f-0000000467.ppm" "ani/f-0000000468.ppm" "ani/f-0000000469.ppm" "ani/f-0000000470.ppm" "ani/f-0000000471.ppm" "ani/f-0000000472.ppm" "ani/f-0000000473.ppm" "ani/f-0000000474.ppm" "ani/f-0000000475.ppm" "ani/f-0000000476.ppm" "ani/f-0000000477.ppm" "ani/f-0000000478.ppm" "ani/f-0000000479.ppm" "ani/f-0000000480.ppm" "ani/f-0000000481.ppm" "ani/f-0000000482.ppm" "ani/f-0000000483.ppm" "ani/f-0000000484.ppm" "ani/f-0000000485.ppm" "ani/f-0000000486.ppm" "ani/f-0000000487.ppm" "ani/f-0000000488.ppm" "ani/f-0000000489.ppm" "ani/f-0000000490.ppm" "ani/f-0000000491.ppm" "ani/f-0000000492.ppm" "ani/f-0000000493.ppm" "ani/f-0000000494.ppm" "ani/f-0000000495.ppm" "ani/f-0000000496.ppm" "ani/f-0000000497.ppm" "ani/f-0000000498.ppm" "ani/f-0000000499.ppm"))
(gimp-quit 0)
