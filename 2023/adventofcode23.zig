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
const genK = R.genK;
const gen2S = R.gen2S;

const spl = R.spl;
const eql = R.eql;
const eq2 = R.eq2;
const swp = R.swp;
const dup = R.dup;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const sum = R.sum;


// Globals //
const dbg = &R.dbg;
const aoc = "23";


// Debug //
//const D = 1000000;
const D = 1;
const suf = "-t";


// Parse input //
const T = enum {
    S,
    F,
    U,
    D,
    L,
    R
};
fn dec(v: anytype) !T {
    return switch(v) {
        '#' => T.S,
        '.' => T.F,
        '>' => T.R,
        '<' => T.L,
        '^' => T.U,
        'v' => T.D,
        else => {
            try err("dec", v);
            return error.type;
        }
    };
}
fn sho(v: anytype) !u8 {
    const w = "#.<>^v";

    for (w) |c| {
        if (try dec(c) == v) return c;
    }

    return error.sho;
}


// Data //
const L = 2;
const K = [L]u64;
const C = genK(L, T);
const Q = [2]K;


// Logic //
fn par(g: anytype, d: []u8) !C {

    var c = try C.init(g);

    var k: K = undefined;

    // Line //
    var i: u64 = 0;
    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        defer i += 1;
        k[0] = i;

//        var ws = spl(l, "~");
//        while (ws.next()) |w| {
//            if (w.len == 0) continue;

//            var vs = spl(w, ",");
//            while (vs.next()) |v| {
//                if (v.len == 0) continue;

        var j: u64 = 0;
        for (l) |v| {
            defer j += 1;

            k[1] = j;

            const z = try dec(v);

//                deb("add", .{i, k[i], c.b[i]});

            try c.add(k, z);
        }

//        }

//// Post //
//        var q: Q = undefined;
//
//        var s = true;
//
//        for (0..3) |x| {
//
//            q.k[x] = k[0][x];
//
//            if (k[0][x] == k[1][x]) continue;
//
//            assert(s);
//
//            s = false;
//            q.d = x;
//            q.v = k[1][x];
//
//            if (q.v < q.k[x]) swp(&q.v, &q.k[x]);
//
//            assert(q.k[x] <= q.v);
//        }
//
//        if (s) {
//            q.d = 0;
//            q.v = q.k[0];
//        }
//
//        assert(q.k[2] > 0);
//
//        q.k[2] -= 1;
//
//        if (q.d == 2) q.v -= 1;
//        
//        try c.add(q);

//// Map //
//        for (l, 0..) |v, j| {
//
//            k[1] = j;
//
////            if (j <= 0) continue;
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
    }


//// Offset //    
//    for (0..2) |z| {
//
//        const o = c.b[z] + 1;
//
//        while (c.p[z] < Z)
//            c.p[z] += o;
//    }

    return c;
}


// Run //
fn run(l: anytype, c: anytype, z: anytype) !u64 {

//    _ = l;

    // Loop control //
    var d: u64 = D;
    var i: u64 = 0;


    // Debug //
    if (z > 0) {
        dbg.* = true;
        d = z;
    }

    // Timestamp //
    const t = tst();


    // Queue //
    var q = HashArray(Q, void).init(l);
    defer q.deinit();


    // Alt Q. //
    var n = HashArray(Q, void).init(l);
    defer n.deinit();


    // Values //
    const V = struct {u64, K};
    const W = genK(2, V);

    var v = try W.init(l);
    defer v.deinit();


    // Start //
    const s, const e = try sta(c, v);

    try q.put(.{s, s}, {});
    try v.add(s, .{0, s});


    while (q.count() > 0) {

        defer i += 1;

        if (i % d == 0) {
            prl();
            deb("run", .{i+1, tst() - t});
        }

        for (q.keys()) |k| {

            try pla(c, k, &n, &v);
        }

        try pra(c, v);

        q.clearRetainingCapacity();
        swp(&q, &n);
    }

    return try fin(c, &v, e, s);
}

fn sta(
    c: anytype,
    z: anytype

) !Q {

    putd("  c", c.count());
    putd("c.b", c.b);

    try pra(c, z);

    var k: K = undefined;
    var q: Q = undefined;
    var f = false;

    for (0 .. c.b[0]+1) |x| {

        k[0] = x;

        for (0 .. c.b[1]+1) |y| { 
       
            k[1] = y;

            const v = try c.get(k);

            if (v == T.F) {

                if (!f) {
                    q[0] = k;
                    f = true;

                } else {

                    q[1] = k;
                }
            }
        }
    }

    if (!f)
        return error.sta;

    return q;
}

fn pla(
    c: anytype,
    k: anytype,
    q: anytype,
    z: anytype

) !void {

//    deb("pla", k);

    var n = k[0];

    for (0 .. 3) |i| {

        if (itr(i, 0, k[0], &n, c)) continue;

        for (0 .. 3) |j| {

            const x = (i == 1 or j == 1) and !(i == 1 and j == 1);

            if (!x) continue;

            if (itr(j, 1, k[0], &n, c)) continue;

            // visited //
            if (eq2(k[1], n)) continue;

            try mov(c, q, n, k[0], z);
        }
    }
}

fn mov(
    c: anytype,
    q: anytype,
    o: anytype,
    h: anytype,
    z: anytype,

) !void {

    var n = o;
    var b = h;

    while (true) {

        const v = try c.get(n);

        const s: ?K = switch (v) {

            T.F => null,

            T.S => return,

            T.D => .{2, 1},
            T.U => .{0, 1},
            T.L => .{1, 0},
            T.R => .{1, 2},
        };

        var g = try z.get(b);

        g[0] += 1;
        g[1] = b;

        if (z.contains(n)) {

            const w = try z.get(n);

            // old is better //
            if (g[0] <= w[0]) return;

            if (try hst(z, b, n)) return;

//            try err("new", .{b, n, g[0], w[0]});
        }

        deb("mov", .{n, g});
        try z.add(n, g);

        if (s) |m| {

            const l = ski(c, m, n, b);

            if (l) |w| {

                b = n;
                n = w;

            } else return;

            continue;
        }

        break;
    }

    try q.put(.{n, b}, {});
}

fn ski(
    c: anytype,
    m: anytype,
    b: anytype,
    k: anytype,

) ?K {

    deb("ski", .{b, m, k});

//    var n = dup(b);
    var n = b;

    for (0..2) |i| {
        if (itr(m[i], i, b, &n, c)) return null;
    }

    if (eq2(k, n)) return null;

    return n;
}

fn hst(
    z: anytype,
    b: anytype,
    n: anytype,

) !bool {

//    deb("hst", .{b, n});

    if (eq2(b, n)) return true;

    _, const g = try z.get(b);

    if (eq2(b, g)) return false;

    return try hst(z, g, n);
}

fn itr(
    i: anytype,
    x: anytype,
    k: anytype,
    n: anytype,
    c: anytype,

) bool {

    if (i == 0 and n[x] <= 0) {
        deb("oob", .{i, n[x]});
        return true;
    }

    if (i == 2 and n[x] >= c.b[x]) {
        deb("oob", .{i, n[x]});
        return true;
    }

    n[x] = k[x] + i - 1;

    return false;
}


fn fin(
    c: anytype,
    z: anytype,
    e: anytype,
    s: anytype,

) !u64 {

    prs("-----------------------------------------------------------");

    dpr("\n  z: {any}\n", .{z.count()});

    var p = try z.clone();
    defer p.deinit();

    p.clear();

    var r: u64 = 0;

    var n = e;

    while (!eq2(n, s)) {

        const vk = try z.get(n);

        const v, const k = vk;

        deb("vk", vk);

        try p.add(n, vk);

        n = k;

        if (r == 0) r = v;
    }

    try pra(c, p);

    return r;
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
    z: anytype,

) !void {

    if (!dbg.*) return;

    prl();

//    var s = try cor(l, c);
//    defer s.deinit();

    var k: K = undefined;

    for (0 .. c.b[0]+1) |x| {

        k[0] = x;

        prs("   ");

        for (0 .. c.b[1]+1) |y| { 
       
            k[1] = y;

            const v = try c.get(k);

            const q = if (v == T.F and z.contains(k)) 'O'
                else try sho(v);

            dpr("{c}", .{q});
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

    const f = "data" ++ aoc ++ suf ++ ".txt";

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) dbg.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Fake Main //
pub fn main() !void {

    // Fun! //
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const l = are.allocator();

    // Speed! //
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const l = gpa.allocator();

    try rmain(l, 0);
}


// Test! //
test "main" {
    dbg.* = true;

    prl();

    const l = std.testing.allocator;

    try rmain(l, D);
}
