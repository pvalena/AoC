const R = @import("class.zig");

const std = R.std;
const assert = R.assert;
const tst = R.tst;

const Array = R.Array;
const Hash = R.Hash;
const HashArray = R.HashArray;
const StringHash = R.StringHash;
const StringHashArray = R.StringHashArray;

const gen = R.gen;
const genH = R.genH;
const genK = R.genK;
const genQ = R.genQ;
const genD = R.genD;

const ini = R.ini;
const res = R.res;
const spl = R.spl;
const swp = R.swp;
const nus = R.nus;
const eq2 = R.eq2;
const sort = R.sort;

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


// Globals //
const G = &R.dbg;
const K = i64;


// _______________________________________________________ //

// Parse input //
const T = enum {
    S,
    F,
    O,
};
fn dec(v: usize) !T {
    return @enumFromInt(v);
}
fn sho(g: anytype) u8 {

    if (g) |i| {

        const v = @abs(i);

        const w = "#.OS";

        assert(v < w.len);

        return w[v];

    } else return ' ';
}


// Input Data //
//const A = Array(K);
const C = gen(K);


// Logic //
fn par(a: anytype, d: []u8) !C {

    var c = C.init(a);

    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

//        puts("l", l);

        try c.new();

        var i: u64 = 0;

        var w = spl(l, " ");
        while (w.next()) |v| {
            if (v.len == 0) continue;

            defer i += 1;

            const n = try nus(K, v);

            if (i < 0) try err("par", .{n, v});

//            deb("n", .{n, v});

            try c.add(n);
        }
    }

    return c;
}


// Status //
//const S = struct {
//    u64,
//    K,
//    K,
//};
const B = genD(Hash(K, K), K);


// Run //
fn run(a: anytype, c: anytype, dd: anytype) !u64 {

    // Debug //
    const d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else 0;

    var m: u64 = 0;
    var z: u64 = 0;

//    c.srt();

//    var w = try B.init(a);
//    defer w.deinit();

//    for (0..c.len()) |i| {
//
//        const b = try c.itm(i);
//
//        try w.inc(b[0], b[1]);
//    }

//    while (c.any()) {
//
//        defer m += 1;
//
//        const b = try c.pop();
//
//        z += try lop(a, d, &b, &w);
//    }

    for (c.items()) |b| {

        defer m += 1;

        dpr("\n{d}> {any}\n", .{m, b.items});

        if (try lop(a, d, b.items)) {

            z += 1;

            deb("z", z);
        }
    }

    return z;
}


// Data //
//const V = genK(Hash, 2, K, K);
//const L = [2]K;


// Machine state //
//const B = struct {
//    Array(K),
//    S,
//};
//const D = struct {
//    pub fn d(_: L, c: B) void {
//
//        c[0].deinit();
//    }
//}.d;
//const Q = genQ(L, B);


// Preset //
const M = 10000;
//const M = 1;

fn lop(
    a: anytype,
    d: anytype,
    b: anytype,

) !bool {

    const m = if (d > 0) d else M;

    _ = a;
    _ = m;


//    // Visited //
//    var v = try V.init(a);
//    defer v.deinit();
//
//
//    // Queue //
//    var q = try Q.init(a, D);
//    defer q.deinit();
//
//
//    // Init //
//    const p: L = .{ 0, 0 };
//    const s: S = .{ 0, 0, 0 };
//
//    // Queue auto-deinits everything in it with destructor //
//    const c = try b.clone();
//    try q.add(p, .{ c, s });
//    try v.add(p, 3);
//
//
//    var i: u64 = 0;
//    const t = tst();
//
//    var o: ?L = null;
//
//    while (q.next()) |w| {
//
//        defer i += 1;
//        const z, const g = w;
//        defer D(z, g);
//
//        if (i % m == 0) {
//            dpr("\n>> {d} : {d}\n", .{i, tst() - t});
//
//            v.prd(sho);
//        }
//
//        if (try sea(z, g, &q, &v)) |n| {
//
//            if (o) |_| try err("2ox", n);
//
//            o = n;
//        }
//   }
//
//    v.prd(sho);
//
//    if (o) |n| return try fil(a, n, &v);

    var n: K = -1;
    var t: K = -2;

    while (n < b.len and n > t) {

        t = n;

        if (n >= 0) deb("n", n);

        const g = try pla(b, &n);

        if (g) return true;

        if (n < 0) try err("n", n);

        if (t == n) n += 1;
    }

    return false;
}


fn pla(
    b: anytype,
    n: anytype,

) !bool {

    var f: K = -1;
    var w: K = 0;
    var i: K = 0;

    for (b) |s| {

        defer i += 1;

        if (i == n.*) continue;

        defer f = s;

        if (f < 0) continue;

        const g = try val(f, s, &w);

        if (!g) {

            if (i < 1) try err("i", .{f, s, w, i, n.*});

            if (n.* >= 0) {

                deb("g", .{f, s, w, i, n.*});

            } else {

                n.* = i - 2;

                while (n.* < 0) n.* += 1;
            }

            return false;
        }
    }

    return true;
}

fn val(
    f: anytype,
    s: anytype,
    w: anytype

) !bool {

    if (f == s) return false;

    const v = s - f;

    if (w.* == 0) w.* = v;

    if (w.* < 0) {

        if (v > 0 or v < -3) return false;

    } else {

        if (v < 0 or v > 3) return false;
    }

    return true;

//    var x, var r, var y = w.*;
//
//    var m: [3]u64 = undefined;
//
//    while (true) {
//
////        const o = x;
//
//        const v = try cod(c, &x, &m);
//
//        if (99 == v) return 0;
//
//        if (3 == v) {
////            deb("inp", c.items[o..o+2]);
//
//            assert(m[0] != 1);
//
//            const f = try adr(c, &x, m[0], r);
//
//            try set(c, f, y);
//            continue;
//        }
//
//        const f = try val(c, &x, m[0], r);
//
//        if (9 == v) {
////            deb("rel", .{ c.items[o..o+2], r, f });
//
//            r += f;
//            continue;
//        }
//
//        if (4 == v) {
////            deb("out", c.items[o..o+2]);
//
//            y = f;
//            break;
//        }
//
//        const s = try val(c, &x, m[1], r);
//
//        if (v >= 5 and v <= 6) {
////            deb("jmp", c.items[o..o+3]);
//
//            if ((v == 5 and f != 0) or (v == 6 and f == 0)) x = @intCast(s);
//
//            continue;
//        }
//
//        const z: K = switch (v) {
//
//            1 => f + s,
//            2 => f * s,
//
//            7 => if (f < s) 1 else 0,
//            8 => if (f == s) 1 else 0,
//
//            else => {
//                try err("pla", v);
//                return null;
//            }
//        };
//
////        deb("oth", c.items[o..o+4]);
//
//        const g = try adr(c, &x, m[2], r);
//
//        try set(c, g, z);
//    }
//
//    w.* = .{x, r, y};
//    return null;

}


//fn cln(
//    c: anytype,
//    l: anytype,
//    r: anytype
//
//) !B {
//
//    const b = try c.clone();
//    r.* = true;
//
//    return .{b, l};
//}

//fn sea(
//    p: anytype,
//    w: anytype,
//    q: anytype,
//    v: anytype,
//
//) !?L {
//
//    const c, const l = w;
//
//    var r = false;
//    var b, var s = try cln(c, l, &r);
//
//    var o: ?L = null;
//
//    for (1..5) |i| {
//
//        if (!r) b, s = try cln(c, l, &r);
//
//        // TODO: optimize //
//        s[2] = @intCast(i);
//
//        const d = dir(i);
//
//        const n = nex(d, p);
//
//        assert(!eq2(n, p));
//
//        if (v.contains(n)) continue;
//
//        if (try pla(&b, &s)) |x| {
//
//            try err("exi", x);
//        }
//
//        // IO //
//        const z = s[2];
//
////            deb("z", .{n, z, d});
//
//        try v.add(n, z);
//
//        _ = switch (z) {
//
//            0 => continue,
//
//            1 => {},
//
//            2 => o = n,
//
//            else => try err("swi", z)
//        };
//
//        // Step //
//        try q.add(n, .{ b, s });
//        r = false;
//    }
//
//    if (r) b.deinit();
//
//    return o;
//}
//
//
//const H = genQ(L, void);

//fn fil(
//    a: anytype,
//    p: anytype,
//    v: anytype,
//
//) !u64 {
//    
//    var q = try H.init(a, null);
//    defer q.deinit();
//
//    try v.add(p, 2);
//    try q.put(p);
//
//    var i = q.steps();
//
//    while (q.next()) |w| {
//
//        const z, _ = w;
//
//        if (q.s != i) {
//            i = q.s;
//
//            deb("s", q.s);
//            v.prd(sho);
//        }
//
//        for (1..5) |g| {
//            const d = dir(g);
//
//            const n = nex(d, z);
//
//            if (!v.contains(n)) continue;
//
//            const x = try v.get(n);
//
//            if (x == 0 or x == 2) continue;
//
//            try v.add(n, 2);
//            try q.put(n);
//        }
//    }
//
//    // Starting pos //
//    return q.steps() - 1;
//}
//
//fn nex(
//    d: anytype,
//    p: anytype,
//
//) L {
//
//    return .{d[0] + p[0], d[1] + p[1]};
//}
//
//fn dir(
//    i: anytype,
//
//) L {
//    return switch(i) {
//        1 => .{-1,  0},
//        2 => .{ 1,  0},
//        3 => .{ 0, -1},
//        4 => .{ 0,  1},
//        else => .{0, 0}
//    };
//}


fn set(
    c: anytype,
    y: anytype,
    z: anytype,

) !void {

    const x: u64 = @intCast(y);

    while (x >= c.items.len) try c.*.append(0);

    const b = c.items;

    assert(x < b.len);

    b[ x ] = z;
}

fn get(
    c: anytype,
    y: anytype,

) !K {

    if (y < 0) try err("get", y);

    const x: u64 = @intCast(y);

    while (x >= c.items.len)
        try c.append(0);

    const b = c.items;

    return b[ x ];
}

fn cod(
    c: anytype,
    x: anytype,
    m: anytype,

) !u64 {

    const a = try adr(c, x, 0, 0);

    var d: u64 = @intCast(a);

    m.* = .{0, 0, 0};

    const v = d % 100;
    d /= 100;

    if (d > 0) {
        
        m[0] = dig(&d);

        if (d > 0) {
            
            m[1] = dig(&d);

            if (d > 0) {
            
                if (d > 0) m[2] = dig(&d);
            }
        }
    }

    return v;
}

fn dig(
    d: anytype,

) u64 {
    
    const t = d.* % 10;

    d.* /= 10;

    assert(t < 3);

    return t;
}

fn adr(
    c: anytype,
    x: anytype,
    m: anytype,
    r: anytype,

) !K {

//    assert(m != 1);

    var a = try get(c, x.*);

    if (m == 2) a += r;

    x.* += 1;

    return a;
}

// _______________________________________________________ //


// Real Main //
fn rmain(l: anytype, nn: anytype, f: anytype) !void {
    prl();

    var n: u64 = nn;

    const d = try ini(l, f, &n);
    defer l.free(d);

    if (n > 0) G.* = true;

    var a = try par(l, d);
    defer a.deinit();

    const r = try run(l, &a, n);
    res(r);
}


// Main -- wrapper //
pub fn main() !void {

    // Fun! //
//    var a = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer a.deinit();
//    const l = a.allocator();

    // Speed! //
    var a = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = a.deinit();
    const l = a.allocator();

    try rmain(l, 0, undefined);
}


// Test -- wrapper //
test "main" {
    G.* = true;

    const l = std.testing.allocator;

    const f = "data2-t.txt";

    try rmain(l, 100, f);
}
