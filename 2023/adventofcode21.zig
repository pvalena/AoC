// Import //
const R = @import("class.zig");

const std = R.std;
const fmt = R.fmt;
const io = R.io;
const mem = R.mem;
const debug = R.debug;
const assert = R.assert;
const stdout = R.stdout;
const tst = R.tst;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
const putc = R.putc;
const err = R.err;
const wip = R.wip;
const pr = R.pr;
const dpr = R.dpr;
const prl = R.prl;
const prs = R.prs;

const lin = R.lin;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;
const gen2S = R.gen2S;

const spl = R.spl;
const eql = R.eql;
const swp = R.swp;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const sum = R.sum;


// Globals //
const dbg = &R.dbg;
const aoc = "21";
const suf = "-t";

// Input //
const T = enum {
    S,
    R,
    F
};
fn dec(v: anytype) !T {
    return switch(v) {
        'S' => T.S,
        '#' => T.R,
        '.' => T.F,
        else => {
            try err("dec", v);
            return error.type;
        }
    };
}

//const S = enum {
//    L,
//    H,
//};
//fn ind(v: anytype) !S {
//    return switch(v[0]) {
//        'l' => S.L,
//        'h' => S.H,
//        else => {
//            try err("ind", v);
//            return error.type;
//        }
//    };
//}
//
//const N = []const u8;
//const M = struct {
//    t: T,
//    s: S,
//    c: Array(N)
//};
const K = [2]u64;


// Data //
const A = genH(K);
//const B = gen2S(S);

const C = struct {
    a: A,
    p: K,
    b: K,

    al: mem.Allocator,

    fn init(al: anytype) C {
        var c: C = undefined;

        c.a = A.init(al);
//        c.b = try B.init(al);

        c.p = .{0, 0};
        c.b = .{0, 0};

        c.al = al;

        return c;
    }

//    fn new(sl: anytype) M {
//        var m: M = undefined;
//
//        m.c = Array(N).init(sl.al);
//
//        return m;
//    }

    fn add(sl: anytype, v: anytype) !void {

        try sl.a.add(v);
    }

//    fn put(sl: anytype, n: anytype, v: anytype) !void {
//
//        try sl.a.put(n, v);
//    }
//
//    fn add(sl: anytype, x: anytype, t: anytype) !void {
//
//        if (sl.a.contains(x)) return error.AlreadyIn;
//
//        var o = sl.new();
//
//        o.t = t;
//
//        try sl.a.put(x, o);
//    }

    fn get(sl: anytype, n: anytype) bool {

        return sl.a.l.contains(n);
    }

    fn deinit(sl: anytype) void {
//        var a = sl.a;

//        var i = a.valueIterator();
//
//        while (i.next()) |v| {
//            v.c.deinit();
//        }

        sl.a.deinit();
        
//        sl.b.deinit();
    }
};


//// Queue //
//const Q = struct {
//    n: N,
//    t: S,
//    f: N
//};


// Logic //
fn par(al: anytype, d: []u8) !C {

    var c = C.init(al);
    try c.a.new();

    // split //
//    const s = " ->,";

    var i: u64 = 0;

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

        defer i += 1;

//        var j: u64 = 0;

        if (l.len == 0) continue;

        var k: K = .{i, 0};

        for (l, 0..) |v, j| {
//            if (w.len == 0) continue;

            k[1] = j;

//            if (j <= 0) continue;

            switch (try dec(v)) {
                T.R =>
                    try c.add(k),
                    
                T.S =>
                    c.p = k,
                    
                T.F => {
                    for (0..2) |z| {
                        if (k[z] > c.b[z]) c.b[z] = k[z];
                    }
                },
            }
                    
        }

//        var n: N = undefined;
//        var ws = spl(l, s);
//        while (ws.next()) |w| {
//            if (w.len == 0) continue;
//
//            defer j += 1;
//
//            if (j <= 0) continue;
//
//            if (try dec(w, &m))
//            
//            try m.c.append(w);
//        }

//        try c.put(n, m);
    }

    return c;
}

//fn dat(w: anytype, m: anytype) !N {
//
////    puts("dat; w", w);
//
//    m.t = try dec(w);
//
////    deb("dat; m.t", m.t);
//
//    if (m.t == T.B) return w;
//
//    return w[1..];
//}


fn run(al: anytype, c: anytype, z: anytype) !u64 {

//    _ = al;

    if (z > 0) {
        dbg.* = true;
    }


    // Loop control //
//    const d = 100000000;
    const d = 1;
    var i: u64 = 0;
    var j: u64 = 0;


    // Timestamp //
    const t = tst();


    // Queue //
    var q = Hash(K, void).init(al);
    defer q.deinit();

    try q.put(c.p, {});


    // alt //
    var n = Hash(K, void).init(al);
    defer n.deinit();


    // Visited //
    var v = Hash(K, void).init(al);
    defer v.deinit();


    // Result //
//    var r: [2]u64 = .{0, 0};
//    const r = 6;
    const r = if (z > 0) z else 64;

    while (true) {
        defer i += 1;

//        if (i % d == 0) {
//            puts("", "");
//            deb("i", .{i+1, tst() - t});
//        }

        while (q.count() > 0) {

            if (j % d == 0) {
                puts("", "");
                deb("j", .{j+1, tst() - t});
            }

            defer j += 1;

            var k = q.keyIterator();

            while (k.next()) |s| {

                try v.put(s.*, {});

                try pla(c, s, &n);
            }

            q.clearRetainingCapacity();

            swp(&q, &n);

    //        _ = try fin(c);

            if (j >= r-1) break;
        }

        break;
    }

    pra(c, q);

    return q.count();
}

fn pla(
    c: anytype,
    s: anytype,
    n: anytype

) !void {

    const e = 2;

    for (0..e+1) |i| {
    for (0..e+1) |j| {

        if (i == 1 or j == 1) {} else continue;
        if (i == 1 and j == 1) continue;

        // borders //
        if (i <= 0 and s[0] <= 0) continue;
        if (j <= 0 and s[1] <= 0) continue;

        const k: K = .{i + s[0] - 1, j + s[1] - 1};

        for (0..2) |z|
            if (k[z] > c.b[z]) continue;

//        deb("pla", k);

        if (c.get(k)) continue;

//        deb("mov", k);

        try n.put(k, {});
    }}
}

fn pra(
    c: anytype,
    q: anytype,

) void {

    if (!dbg.*) return;

    for (0..c.b[0]+1) |i| {

        prl();
        prs("   ");
        
        for (0..c.b[1]+1) |j| {

            const k = .{i, j};

//            deb("k", k);

            if (c.get(k)) {

                prs("#");

            } else {
                if (q.contains(k)) {

                    prs("O");

                } else {
                    prs(".");

                }
            }
        }
    }

    prl();
}


// Real Main //
fn rmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

    const f = "data" ++ aoc ++ suf ++ ".txt";

    const d = try ini(al, f, &n);
    defer al.free(d);

    if (n > 0) dbg.* = true;

    var a = try par(al, d);
    defer a.deinit();

    const r = try run(al, &a, n);
    res(r);
}


// Fake Main //
pub fn main() !void {

    // Fun! //
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const al = are.allocator();

    // Speed! //
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const al = gpa.allocator();

    try rmain(al, 0);
}


// Test! //
test "main" {
    dbg.* = true;

    puts("", "");

    const al = std.testing.allocator;

    try rmain(al, 0);
}
