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

const ini = R.ini;
const res = R.res;
const spl = R.spl;
const swp = R.swp;
const nus = R.nus;
const eq2 = R.eq2;

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
const F = "15";
const K = i64;


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
const C = gen(K);


// Logic //
fn par(a: anytype, d: []u8) !C {

    var r = C.init(a);

    var ls = spl(d, "\n");
    while (ls.next()) |l| {
        if (l.len == 0) continue;

        try r.new();

        var i: u64 = 0;

        var w = spl(l, ",");
        while (w.next()) |v| {
            if (v.len == 0) continue;

            defer i += 1;

            const n = try nus(K, v);

            try r.add(n);
        }
    }

    return r;
}


// Status //
const S = struct {
    u64,
    K,
    K,
};


// Run //
fn run(a: anytype, c: anytype, dd: anytype) !u64 {

    // Debug //
    const d = if (dd > 0) blk: {
    
        G.* = true;

        break :blk dd;

    } else 0;

    var m: u64 = 0;

    for (c.items()) |b| {

        defer m += 1;

//        deb("o", o.items);

        return try lop(a, d, &b);
    }

    unreachable;
}


// Data //
const V = genK(Hash, 2, K, K);
const L = [2]K;


// Machine state //
const B = struct {
    Array(K),
    S,
};
const D = struct {
    pub fn d(_: L, c: B) void {

        c[0].deinit();
    }
}.d;
const Q = genQ(L, B);


// Preset //
const M = 10000;
//const M = 1;

fn lop(
    a: anytype,
    d: anytype,
    b: anytype,

) !u64 {

    const m = if (d > 0) d else M;


    // Visited //
    var v = try V.init(a);
    defer v.deinit();


    // Queue //
    var q = try Q.init(a, D);
    defer q.deinit();


    // Init //
    const p: L = .{ 0, 0 };
    const s: S = .{ 0, 0, 0 };

    // Queue auto-deinits everything in it with destructor //
    const c = try b.clone();
    try q.add(p, .{ c, s });
    try v.add(p, 3);


    var i: u64 = 0;
    const t = tst();

    var o: ?L = null;

    while (q.next()) |w| {

        defer i += 1;
        const z, const g = w;
        defer D(z, g);

        if (i % m == 0) {
            dpr("\n>> {d} : {d}\n", .{i, tst() - t});

            v.prd(sho);
        }

        if (try sea(z, g, &q, &v)) |n| {

            if (o) |_| try err("2ox", n);

            o = n;
        }
   }

    v.prd(sho);

    if (o) |n| return try fil(a, n, &v);

    try err("fail", i);
    return 0;
}

fn cln(
    c: anytype,
    l: anytype,
    r: anytype

) !B {

    const b = try c.clone();
    r.* = true;

    return .{b, l};
}

fn sea(
    p: anytype,
    w: anytype,
    q: anytype,
    v: anytype,

) !?L {

    const c, const l = w;

    var r = false;
    var b, var s = try cln(c, l, &r);

    var o: ?L = null;

    for (1..5) |i| {

        if (!r) b, s = try cln(c, l, &r);

        // TODO: optimize //
        s[2] = @intCast(i);

        const d = dir(i);

        const n = nex(d, p);

        assert(!eq2(n, p));

        if (v.contains(n)) continue;

        if (try pla(&b, &s)) |x| {

            try err("exi", x);
        }

        // IO //
        const z = s[2];

//            deb("z", .{n, z, d});

        try v.add(n, z);

        _ = switch (z) {

            0 => continue,

            1 => {},

            2 => o = n,

            else => try err("swi", z)
        };

        // Step //
        try q.add(n, .{ b, s });
        r = false;
    }

    if (r) b.deinit();

    return o;
}


const H = genQ(L, void);

fn fil(
    a: anytype,
    p: anytype,
    v: anytype,

) !u64 {
    
    var q = try H.init(a, null);
    defer q.deinit();

    try v.add(p, 2);
    try q.put(p);

    var i = q.steps();

    while (q.next()) |w| {

        const z, _ = w;

        if (q.s != i) {
            i = q.s;

            deb("s", q.s);
            v.prd(sho);
        }

        for (1..5) |g| {
            const d = dir(g);

            const n = nex(d, z);

            if (!v.contains(n)) continue;

            const x = try v.get(n);

            if (x == 0 or x == 2) continue;

            try v.add(n, 2);
            try q.put(n);
        }
    }

    // Starting pos //
    return q.steps() - 1;
}

fn nex(
    d: anytype,
    p: anytype,

) L {

    return .{d[0] + p[0], d[1] + p[1]};
}

fn dir(
    i: anytype,

) L {
    return switch(i) {
        1 => .{-1,  0},
        2 => .{ 1,  0},
        3 => .{ 0, -1},
        4 => .{ 0,  1},
        else => .{0, 0}
    };
}

fn pla(
    c: anytype,
    w: anytype,

) !?K {
    var x, var r, var y = w.*;

    var m: [3]u64 = undefined;

    while (true) {

//        const o = x;

        const v = try cod(c, &x, &m);

        if (99 == v) return 0;

        if (3 == v) {
//            deb("inp", c.items[o..o+2]);

            assert(m[0] != 1);

            const f = try adr(c, &x, m[0], r);

            try set(c, f, y);
            continue;
        }

        const f = try val(c, &x, m[0], r);

        if (9 == v) {
//            deb("rel", .{ c.items[o..o+2], r, f });

            r += f;
            continue;
        }

        if (4 == v) {
//            deb("out", c.items[o..o+2]);

            y = f;
            break;
        }

        const s = try val(c, &x, m[1], r);

        if (v >= 5 and v <= 6) {
//            deb("jmp", c.items[o..o+3]);

            if ((v == 5 and f != 0) or (v == 6 and f == 0)) x = @intCast(s);

            continue;
        }

        const z: K = switch (v) {

            1 => f + s,
            2 => f * s,

            7 => if (f < s) 1 else 0,
            8 => if (f == s) 1 else 0,

            else => {
                try err("pla", v);
                return null;
            }
        };

//        deb("oth", c.items[o..o+4]);

        const g = try adr(c, &x, m[2], r);

        try set(c, g, z);
    }

    w.* = .{x, r, y};
    return null;
}

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

fn val(
    c: anytype,
    x: anytype,
    m: anytype,
    r: anytype,

) !K {

    const a = try adr(c, x, m, r);

    if (m == 1) return a;

    return try get(c, a);
}

// Real Main //
fn rmain(l: anytype, nn: anytype) !void {
    prl();

    var n: u64 = nn;

    const f = "data" ++ F ++ ".txt";

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

    const l = std.testing.allocator;

    try rmain(l, 100);
}
