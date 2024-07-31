#Write simple TCL script for wired scenario
#31/07/24 9:03am 
#By Anshuman Joshi

set ns [new Simulator]

set namfile [open wired.nam w]
$ns namtrace-all $namfile

set tracefile [open wired.tr w]
$ns trace-all $tracefile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 2Mb 1ms DropTail
$ns duplex-link $n1 $n2 2Mb 1ms RED
$ns duplex-link $n2 $n3 2Mb 1ms SFQ

$ns at 1.0 "$n0 label Source_Node"
$ns at 1.0 "$n3 label Destination_Node"

$n0 color red
$n1 color blue
$n2 color green
$n3 color orange

set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]

$ns attach-agent $n0 $tcp
$ns attach-agent $n3 $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns connect $tcp $sink

$ns at 1.0 "$ftp start"
$ns at 5.0 "finish"

proc finish {} {
    global ns namfile tracefile
    $ns flush-trace
    close $namfile
    close $tracefile
    exec nam wired.nam &
    exit 0
}

$ns run
