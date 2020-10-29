use std::sync::Mutex;
// use std::thread;

struct Ip6Pktopts { // ip6_pktopts
    ip6po_hlim: i64,
}

fn ip6_pcbopts(pktopt: &mut Ip6Pktopts) -> i64 {
    pktopt.ip6po_hlim = 1;
    0
}

fn ip6_ctloutput(m: Mutex<Ip6Pktopts>) -> i64 {
    /* xxx TODO:
     * Should implement rwlock instead of mutex? */
    let mut pktopt = m.lock().unwrap();
    ip6_pcbopts(&mut pktopt)
}

fn main() {
    let pktopt = Ip6Pktopts { ip6po_hlim: 0 };
    let m = Mutex::new(pktopt);
    ip6_ctloutput(m);
}
