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
const aoc = "20";


// Input //
const T = enum {
    B,
    F,
    C
};
fn dec(v: anytype) !T {
    return switch(v[0]) {
        '%' => T.F,
        '&' => T.C,
        'b' => T.B,
        else => {
            try err("dec", v);
            return error.type;
        }
    };
}

const S = enum {
    L,
    H,
};
fn ind(v: anytype) !S {
    return switch(v[0]) {
        'l' => S.L,
        'h' => S.H,
        else => {
            try err("ind", v);
            return error.type;
        }
    };
}

const N = []const u8;
const M = struct {
    t: T,
    s: S,
    c: Array(N)
};


// Data //
const A = StringHash(M);
const B = gen2S(S);

const C = struct {
    a: A,
    b: B,

    al: mem.Allocator,

    fn init(al: anytype) C {
        var c: C = undefined;

        c.a = A.init(al);
        c.b = try B.init(al);

        c.al = al;

        return c;
    }

    fn new(sl: anytype) M {
        var m: M = undefined;

        m.c = Array(N).init(sl.al);

        return m;
    }

    fn put(sl: anytype, n: anytype, v: anytype) !void {

        try sl.a.put(n, v);
    }

    
    fn add(sl: anytype, x: anytype, t: anytype) !void {

        if (sl.a.contains(x)) return error.AlreadyIn;

        var o = sl.new();

        o.t = t;

        try sl.a.put(x, o);
    }

    fn get(sl: anytype, n: anytype) !M {

        return sl.a.get(n) orelse {

            puts("get", n);

            return error.DataMissing;
        };
    }

    fn deinit(sl: anytype) void {
        var a = sl.a;

        var i = a.valueIterator();

        while (i.next()) |v| {
            v.c.deinit();
        }

        a.deinit();
        
        sl.b.deinit();
    }
};


// Queue //
const Q = struct {
    n: N,
    t: S,
    f: N
};


// Logic //
fn par(al: anytype, d: []u8) !C {

    var c = C.init(al);

//    var i: u64 = 0;

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

//        defer i += 1;

        var j: u64 = 0;
        const s = " ->,";

        if (l.len == 0) continue;

        var m = c.new();

        var ws = spl(l, s);
        while (ws.next()) |w| {
            if (w.len == 0) continue;

            defer j += 1;

            if (j <= 0) continue;

            try m.c.append(w);
        }

        j = 0;

        var n: N = undefined;

        ws = spl(l, s);
        while (ws.next()) |w| {
            if (w.len == 0) continue;

            defer j += 1;

            if (j > 0) break;

            n = try dat(w, &m);
        }

        try c.put(n, m);
    }

    return c;
}

fn dat(w: anytype, m: anytype) !N {

//    puts("dat; w", w);

    m.t = try dec(w);

//    deb("dat; m.t", m.t);

    if (m.t == T.B) return w;

    return w[1..];
}


fn run(al: anytype, c: anytype, z: anytype) !u64 {

    if (z > 0) {
        dbg.* = true;
    }

//    _ = al;

    // Timestamp //
    const t = tst();

    // Result //
//    var r: [2]u64 = .{0, 0};


    // Finish //
    const l = "rx";


    // Preprocess //
    if (!c.a.contains(l))
        try c.add(l, T.B);

    try pre(c);


    // Input //
    var e: Q = undefined;

    e.n = "broadcaster";
    e.t = S.L;
    e.f = "button";


    // Queue //
    var q = Array(Q).init(al);
    var n = Array(Q).init(al);

    defer q.deinit();
    defer n.deinit();

    var i: u64 = 0;

    const d = 100000000;

    while (true) {
        defer i += 1;

        if (i % d == 0) deb("i", .{i+1, tst() - t});

        try q.append(e);

        var j: u64 = 0;

        while (q.items.len > 0) {

            for (q.items) |s| {

                if (try fin(s, l)) j += 1;
                
                try pla(c, s, &n);
            }

            q.clearRetainingCapacity();

            swp(&q, &n);

    //        _ = try fin(c);

//            try wip();

        }

        if (j > 0) putd(">>>", i+1);

        if (j == 1) break;
    }

    return i;
}

fn pre(
    c: anytype,

) !void {

    var b = &c.b;

    var i = c.a.keyIterator();

    while (i.next()) |k| {

        // y = from //
        const y = k.*;

        const m = try c.get(y);

        const p = m.c.items;

        for (p) |x| {

            // x = to //
            const o = c.get(x) catch {

                try c.add(x, T.B);

                continue;
            };

            if (o.t == T.C) {

                // x: Con. module 
                try b.put(x, y, S.L);
            }
        }
    }
}

fn prs(n: anytype) void {
    if (dbg.*) {

        const hl = if (n.t == S.L) "low" else "high";

        dpr("{s} -{s}-> {s}\n", .{n.f, hl, n.n});
    }
}

fn pla(
    c: anytype,
    s: anytype,
    q: anytype

) !void {

//    prs(s);

    var m = try c.get(s.n);

    var n: Q = undefined;

    n.f = s.n;

    const p = m.c.items;

    switch(m.t) {
        T.B =>
            try bro(s, p, q, &n),

        T.F =>
            try fli(c, &m, s, p, q, &n),

        T.C =>
            try con(&c.b, s, p, q, &n),

//        else => {
//            try err("pla; swi", m.t);
//            return error.type;
//        }
    }
}

fn bro(
    s: anytype,
    p: anytype,
    q: anytype,
    n: anytype
) !void {

    n.t = s.t;

    try enq(p, n, q);   
}

fn fli(
    c: anytype,
    m: anytype,
    s: anytype,
    p: anytype,
    q: anytype,
    n: anytype
) !void {

    if (s.t == S.H) return;

    m.s = if (m.s == S.H) S.L else S.H;

    // store //
    try c.put(s.n, m.*);

//    deb("fli", m.s);

    n.t = m.s;

    try enq(p, n, q);   
}

fn con(
    b: anytype,    // connections from
    s: anytype,    // signal rec.
    p: anytype,    // paths from mod.
    q: anytype,    // queue
    n: anytype     // q. elem
) !void {

//    deb("con", s.t);

    try b.put(s.n, s.f, s.t);

    // read all froms //
    var l = try b.get(s.n);

    var k = l.valueIterator();

    var h = true;

    while (k.next()) |v| {

//        deb("v", v);

        if (v.* == S.L) {
            h = false;
            break;
        }
    }

//    deb("h", h);

    // caching? //
//    m.s = if (m.s == S.H) S.L else S.H;

    n.t = if (h) S.L else S.H;

    try enq(p, n, q);   
}

fn enq(p: anytype, n: anytype, q: anytype) !void {

    for (p) |x| {

        n.n = x;

        try q.append(n.*);
    }
}

fn fin(s: anytype, l: anytype) !bool {

//    const r = try c.get(l);

    if (s.t != S.L) return false;

    return eql(s.n, l);
}


// Real Main //
fn rmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

//    const f = "data" ++ aoc ++ "-t.txt";
    const f = "data" ++ aoc ++ ".txt";

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
