const R = @import("class.zig");

const std = R.std;
const assert = R.assert;
const tst = R.tst;
const fmt = R.fmt;

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
const eql = R.eql;
const spl = R.spl;
const spls = R.spls;
const swp = R.swp;
const nus = R.nus;
const eq2 = R.eq2;
const nex = R.nex;
const sort = R.sort;
const sum = R.sum;

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
const F = "4";

// _______________________________________________________ //

// Parse input //
const W = "XMAS.";
const S = enum {
    X,
    M,
    A,
    S,
    E
};
fn dec(v: anytype) !S {

    var i: usize = 0;

    for (W) |w| {
        defer i += 1;

        assert(i < W.len);

        if (v == w) return @enumFromInt(i);

        if (i == W.len-1) break;
    }

    deb("dec", .{v, i});

    assert(i < W.len);

    return @enumFromInt(i);
}
//fn dec(v: usize) !S {
//    return @enumFromInt(v);
//}
fn sho(g: anytype) u8 {

    if (g) |i| {

        const v = @intFromEnum(i);

        assert(v < W.len);

        return W[v];

    } else return ' ';
}

/////////////////////////////////////
//            while (x.next()) |y| {
//                defer k += 1;

//                if (k > 1) {
//
//                    f = 0;
//                    break;
//                }

//                if (y.len <= 0) try err("y", y);
//
//                const n = fmt.parseInt(K, y, 10) catch {
//
//                    f = 0;
//                    break;
//                };
//
//                if (n < 0) try err("nus", .{n, y});
//
/////////////////////////////////////


// Input Data //
const C = genK(Hash, 2, K, S);

// Logic //
fn par(a: anytype, d: []u8) !C {

    var c = try C.init(a);
//    try c.new();

    var ls = spl(d, "\n");
    var i: K = 0;

    while (ls.next()) |l| {
        defer i += 1;

        if (l.len <= 0) continue;
//            puts("l", l);
//            try err("l", l.len);
//        }

//        puts("l", l);

        var j: K = 0;

        for (l) |v| {
            defer j += 1;

//            putc("v", v);

            const z = try dec(v);

            const k: [2]K = .{i, j};

//            const x: ?S = z;
//            putc("x", sho(x));
//
//            deb("z", .{k, z});

            try c.add(k, z);
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
fn run(a: anytype, c: anytype, dd: anytype) !K {

    // Debug //
    const d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else 0;

    _ = a;
    _ = d;

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

    var m: u64 = 0;
    var z: K = 0;

//    z += 0;

    c.prd(sho);

    c.iterator();

    while (c.next()) |kv| {
        defer m += 1;

        const k, const v = kv;

        if (v != S.X) continue;

        dpr("\n{d}> {any}\n", .{m, k});

        z += try lop(c, k);
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
    c: anytype,
    k: anytype,

) !K {

//    const m = if (d > 0) d else M;

//    _ = a;
//    _ = m;


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

    var t: K = 0;

    const h: [3]K = .{-1, 0, 1};

    var s: [3]S = undefined;

    for (W[1..W.len-1], 0..) |v, i| {

        s[i] = try dec(v);
    }

    for (h) |x| {
    for (h) |y| {

        if (x == 0 and x == y) continue;

//        deb("lop", .{x, y, k});
        
        if (try pla(c, .{x, y}, k, s)) t += 1;
    }}

    return t;
}


fn pla(
    c: anytype,
    d: anytype,
    k: anytype,
    s: anytype

) !bool {

    var n = k;

    for (s) |w| {

        n = nex(n, d);

        const v = try c.getn(n);

        if (v != w) return false;
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

    const f = "data" ++ F ++ "-t.txt";

    try rmain(l, 100, f);
}
