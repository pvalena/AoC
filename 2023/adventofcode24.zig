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
const toc = R.toc;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;
const itr = R.itr;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;
const genK = R.genK;
const gen2S = R.gen2S;

const spl = R.spl;
const eql = R.eql;
const eq2 = R.eq2;
const max = R.max;
const swp = R.swp;
const dup = R.dup;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const nus = R.nus;
const sum = R.sum;


// Globals //
const G = &R.dbg;
const A = "24";
const F = "-t";
const E = 999999999;

// Input //
//const T = enum {
//    S,
//    F,
//    U,
//    D,
//    L,
//    R
//};
//fn dec(v: anytype) !T {
//    return switch(v) {
//        '#' => T.S,
//        '.' => T.F,
//        '>' => T.F,
//        '<' => T.F,
//        '^' => T.F,
//        'v' => T.F,
//        else => {
//            try err("dec", v);
//            return error.type;
//        }
//    };
//}
//fn sho(v: anytype) !u8 {
//    const w = "#.<>^v";
//
//    for (w) |c| {
//        if (try dec(c) == v) return c;
//    }
//
//    return error.sho;
//}


// Data //
const L = 3;
const K = [L]u64;
const C = genK(Hash, L, K);
const Z = 1000;


// Logic //
fn par(g: anytype, d: []u8) !C {

    var c = try C.init(g);

    var k: [2]K = undefined;

    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        var i: u64 = 0;
        var j: u64 = 0;

        var w = spl(l, "@, ");
        while (w.next()) |v| {
            if (v.len == 0) continue;

            defer i += 1;
            
            if (i >= L) {
                j += 1;
                i = 0;
            }

            assert(i < L);
            assert(j < L);

            if (j <= 0) {

                k[j][i] = try num(u64, v);
                continue;
            }
            
            const e = try nus(i64, v);

            if (e > Z)
                try err("e", e);

            k[j][i] = @intCast(Z + e);
        }

//        deb("add", k);

        try c.add(k[0], k[1]);
    }

//// Map //
//        for (l, 0..) |v, j| {
//
//            k[1] = j;
//
//            switch (try dec(v)) {
//
//                T.R =>
//                    try c.add(k),
//                    
//                T.S =>
//                    c.p = k,
//                    
//                T.F => {
//                    for (0..2) |z| {
//                        if (k[z] > c.b[z]) c.b[z] = k[z];
//                    }
//                },
//            }                    
//        }

    return c;
}


// Preset //
const D = 2;
const Q = [L]u64;
//const Q = Hash(u64, void);
const V = genK(Hash, D, Q);

const B = .{200000000000000, 400000000000000};
//const E = .{7, 27}; 

// Skip spaces = speed //
const S = 3*100000;

// Trunc coords = memory //
const M = 5*10000000;


// Run //
fn run(a: anytype, c: anytype, g: anytype) !u64 {

    const s: u64 = S;
    const r: [D]u64 = B;


    // Debug //
    if (g > 0) {

        G.* = true;
//        s = g;
    }

    // Timestamp //
    const t = tst();


    // Visited //
    var n = try V.init(a);
    defer n.deinit();

//    var n = try c.clone();
//    n.clear();


//    // Start //
//    const s, const e = try sta(c);
//
//    try v.add(s, {});
//
//    try q.append(.{s, v});

//    for (0 .. D) |i| {
//
//        r[i] /= 1;
//    }


    // Loop //
    var i: u64 = 0;

    hdr(c, s, r);

    const b = c.count();

    c.iterator();

    while (c.next()) |k| {

        defer i += 1;

        prl();
        prc(b - i, .{k[0][0..D], k[1][0..D], tst() - t});

        try are(a, k, i, &n, r, s, M);
    }

    return try fin(&n, b);
}

fn are(
    a: anytype,
    k: anytype,
    j: anytype,
    q: anytype,
    r: anytype,
    s: anytype,
    m: anytype

 ) !void {

    const o, const v = k;

//    for (0 .. D) |i| {
//
//        o[i] /= m;
//    }

    var l: [D]u64 = undefined;

    for (0 .. D) |i| {

        l[i] = o[i];
    }

    while (true) {

        var f = false;

        for (0 .. D) |i| {

            l[i] = l[i] + v[i]*s - Z*s;

            if (l[i] < r[0] or l[i] > r[1]) f = true;
        }

        if (f) {
            for (0 .. D) |i| {
                if (l[i] > o[i] and l[i] > r[1]) return;
                if (l[i] < o[i] and l[i] < r[0]) return;
            }

            continue;
        }

        // Smooth //

        var n = l;
        
        for (0 .. D) |i| {

            n[i] /= m;
        }

        // In Range //

        var z: Q = undefined;

        if (try q.getn(n)) |x| {

            z = x;

            var d = true;

            for (0..L) |i| {

                if (z[i] == j) {

                    d = false;
                    break;
                }

                if (z[i] == E) {

                    z[i] = j;
    
                    if (i+1 < L) z[i+1] = E;

                    d = false;
                    break;
                }
            }

            if (d) deb("d", .{n, j});

        } else {
            z = .{0,0,0};
            z[0] = j;
            z[1] = E;
            _ = a;

        }

        try q.add(n, z);
    }

    unreachable;
}


fn fin(
    n: anytype,
    b: anytype,

) !u64 {

    prl();
    prs("-----------------------------------------------------------");
    prl();
    putd("n", n.count());

//    try pra(c, z);

    var x: u64 = 0;
//    var j: u64 = 0;

    n.iterator();

    while (n.next()) |k| {

        const l, var z = k;
        var y: u64 = 0;

        for (0..L) |i| {

            if (z[i] == E) {
                y = i;
                break;
            }

            // Print //

            z[i] = b - z[i];            
        } 

        if (y <= 0) y = L;

        if (y <= 1) continue;

        x += 1;

        if (y != 2) {

            dpr(">>> {d}: {d}, {d}, {d}", .{x, z[0], z[1], z[2]});

        } else {

            dpr("> > {d}: {d}, {d}", .{x, z[0], z[1]});
        }

        dpr("    | {any}\n", .{l});

//        prc(x, z);
    }

    if (x <= 0) try err("x", x);

    return x;
}

fn prc(
    v: anytype,
    d: anytype,

) void {
//    dpr("{c}: {any}\n", .{toc(v), d});
    dpr("{d}: {any}\n", .{v, d});
}

fn hdr(
    c: anytype,
    s: anytype,
    r: anytype,

) void {
    const t = G.*;
    G.* = true;

    prl();
    putd("c", c.count());
    deb("s", s);
    deb("r", r);
    deb("M", M);

    G.* = t;
}


//// Diverge //
//fn div(
//    l: anytype,
//    d: anytype,
//    v: anytype,
//
//) !u64 {
//
//    var i = Hash(u64, void).init(l);
//    defer i.deinit();
//
//    var c = try d.clone();
//    defer c.deinit();
//
//    try c.remove(v);
//
//    var x = true;
//
//    while (x) {
//
//        x = false;
//
//        const k = c.keys();
//
//        for (k, 0..) |b, j| {
//
//            if (try pla(&c, k, b, j, 1)) {
//            
//                x = true;
//                try i.put(j, {});
//
//                break;
//            }
//        }
//    }
//
//    return i.count();
//}

fn pra(
    c: anytype,
//    z: anytype,

) !void {

    if (!G.*) return;

    prl();

//    var s = try cor(l, c);
//    defer s.deinit();

    var k: K = undefined;

    for (0 .. c.b[0]+1) |x| {

        k[0] = x;

        prs("   ");

        for (0 .. c.b[1]+1) |y| { 
       
            k[1] = y;

//            const v = try c.get(k);

//            const q = if (v != T.S and z.contains(k)) 'O'
//                else try sho(v);

//            dpr("{c}", .{q});
        }

//    const m = c.b[2]+1;
//
//    const e = ' ';
//
//    for (0..2) |a| {
//
//        prl();
//
//        const b: usize = if (a == 0) 1 else 0;
//
//        for (0 .. m+1) |zz| {
//
//            const z = m - zz;
//
//            dpr("  {d}| ", .{z+1});
//
//            k[2] = z;
//
//            for (0..c.b[a]+1) |x| {
//
//                k[a] = x;
//
//                var w: u8 = e;
//            
//                for (0..c.b[b]+1) |y| { 
//               
//                    k[b] = y;
//
//                    if (s.get(k)) |v| {
//
//                        const q = toc(v);
//
//                        if (w != e and w != q) {
//
//                            w = '?';
//                            break;
//                        }
//
//                        w = q;
//                    }
//                }
//
//                dpr("{c}", .{w});
//            }
//
//            prl();
//        }

        prl();
    }
}


// Real Main //
fn rmain(l: anytype, nn: anytype) !void {
    prl();

    var n: u64 = nn;

    const f = "data" ++ A ++ F ++ ".txt";

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) G.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Fake Main //
pub fn main() !void {

    // Fun! //
//    var a = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer a.deinit();
//    const l = a.allocator();

    // Speed! //
    var a = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = a.deinit();
    const l = a.allocator();

    try rmain(l, 0);
}


// Test! //
test "main" {
    G.* = true;

    prl();

    const l = std.testing.allocator;

    try rmain(l, 0);
}
