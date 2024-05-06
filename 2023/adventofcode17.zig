
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

const spl = R.spl;
const eql = R.eql;
const swp = R.swp;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
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
const HashMap = R.HashMap;
const HashArray = R.HashArray;

const gen = R.gen;
const num = R.num;


// Globals //
const dbg = &R.dbg;


// Data //
//const N3 = Array(Array(T));
//const D3 = struct {
//    al: mem.Allocator,
//    d: Array(N3),
//    l: *N3,
//    w: u64,
//    h: u64,
//
//    fn init(al: anytype) D {
//        var s: D = undefined;
//
//        s.al = al;
//        s.d = Array(N3).init(al);
//
//        s.h = 0;
//        s.w = 0;
//        
//        return s;
//    }
//
//    fn new(sl: anytype) !void {
//        const l = N3.init(sl.al);
//
//        try sl.d.append(l);
//
//        const i = sl.d.items;
//
//        sl.h = i.len;
//
//        sl.l = &i[i.len-1];
//    }
//
//    fn row(sl: anytype) !*N {
//        const n = N.init(sl.al);
//
//        try sl.l.append(n);
//
//        const i = sl.l.items;
//
//        if (i.len > sl.w) sl.w = i.len;
//
//        return &i[i.len-1];
//    }
//
//    fn get(sl: anytype, j: anytype, c: anytype, k: anytype) T {
//        return sl.d.items[j].items[c].items[k];
//    }
//
//    fn deinit(sl: anytype) void {
//        for (sl.d.items) |i| {
//            
//            for (i.items) |j| {
//
//                j.deinit();
//
//            }
//            i.deinit();
//
//        }
//        sl.d.deinit();
//    }
//};


// Types //
const T = enum {
    fre,
    vsp,
    hsp,
    mil,
    mir,
};

// IO //
fn dec(v: anytype) !T {
    return switch(v) {
        '.' => T.fre,
        '/' => T.mir,
        '\\' => T.mil,
        '-' => T.hsp,
        '|' => T.vsp,

        else => return error.type
    };
}

fn con(t: anytype) u8 {
    return switch(t) {
        T.fre => '.',
        T.mir => '/',
        T.mil => '\\',
        T.hsp => '-',
        T.vsp => '|',
    };
}


// Structure //
const Ti = u8;
const Di = gen(Ti);


// Input //
fn par(al: anytype, d: []u8) !Di {

    // Multi-Data
    var a = Di.init(al);
//    try a.new();

    // Line
    var ls = spl(d, "\n");

    while (ls.next()) |l| {
        if (l.len == 0) {

//            if (a.l.items.len > 0) {
//                try a.new();
//            }
        
            continue;
        }

        // Elems
        var ws = spl(l, " ");
        var i: u64 = 0;

        while (ws.next()) |w| {
            defer i += 1;

//            puts("w", w);

            if (w.len == 0) {
                try err("zero", l);
                continue;
            }

            try a.new();
//            try a.add(w);
            try dat(a, w, i);
        }
    }

    return a;
}

fn dat(x: anytype, w: anytype, i: anytype) !void {

    if (i == 0) {
        for (w) |v| {
            const n: u8 = try num(&[_]u8{v}, u8);

//            try err("Entry", n);

            try x.add(n);
        }

        return;
    }

    try err("Invalid entry", w);
}


// Logic //
const K = [2]i64;

const L = struct {
    p: K,
    d: K,
    m: u8,
};

const V = struct {
    v: u64,
    p: Array(K),
};

fn run(al: anytype, d: anytype, b: anytype) !u64 {

//    Timestamp
//    const t = tst();

    _ = b;

    // visited //
//    var s = HashMap(L, .{u64, Array(K)}).init(al);
    var s = HashMap(L, V).init(al);
    defer s.deinit();

    // active //
    var l = HashArray(L, V).init(al);
    defer l.deinit();

    // new //
    var n = HashArray(L, V).init(al);
    defer n.deinit();

    // paths //
    var z: L = undefined;
//    var i: i64 = 0;

    const h: i64 = @intCast(d.h());
    const w: i64 = @intCast(d.w());

    // top //
//    i = 0;
//    while (i < w) {
//        defer i += 1;

        // Starting position //
        z.p = .{ 0, 0 };
        z.d = .{ 0, 0 };
        z.m = 0;

        // Starting value //
        var v: V = undefined;
        v.v = 0;

        var p = Array(K).init(al);
        try p.append(z.p);

        v.p = p;

        try l.putNoClobber(z, v);
        try ply(&l, d, &n, &s);
//    }

//    try err("run", m);

    return fin(s, h-1, w-1);
}

fn ply(
    l: anytype,
    x: anytype, n: anytype, s: anytype,
) !void {

    // End //
    const xw = x.w() - 1;
    const xh = x.h() - 1;

    // Best solution //
    var m: V = undefined;
    m.v = 10000000;

    // iterations //
    var q: u64 = 0;

    while (l.count() > 0) {
        while (l.count() > 0) {
            defer q += 1;

            const kv = l.pop();

            const k = kv.key;
            const v = kv.value;
            defer v.p.deinit();

            dpr("{any}: {}\n", .{k.p, v.v});

            if (v.v >= m.v) continue;

            // Logging visited //
            var w: V = undefined;

            w.v = v.v;
            w.p = try v.p.clone();

            const i = try lput(&s, k, w);

            if (!i) {
                continue;
            }

            const p = k.p;

            if (p[0] == xh and p[1] == xw) {
                
                m = v;
            
                putd("m", m.v);
                break;
            }

//            if (q < 10)
                try lop(x, k, v, &n);


//            pra(x, s);
        }

        swp(n, l);
    }
}

fn lop(x: anytype, l: anytype, v: anytype, n: anytype) !void {
    var h: i64 = -1;
    while (h <= 1) {
        defer h += 1;

        var r: i64 = -1;
   
        while (r <= 1) {
            defer r += 1;

            if (r != 0 and h != 0) continue;
            if (r == 0 and h == 0) continue;
            if (r == 0 and h == -l.d[0]) continue;
            if (h == 0 and r == -l.d[1]) continue;

            try mov(x, l, v, n, h, r);
        }
    }
}

fn mov(
    x: anytype, l: anytype, v: anytype, n: anytype,
    h: anytype, r: anytype

) !void {

    const d = (l.d[0] == h and l.d[1] == r);
    
    if (d and l.m >= 3) return;

    const p: K = .{ l.p[0] + h, l.p[1] + r };

    if (p[0] < 0 or p[1] < 0) return;
    if (p[0] >= x.h() or p[1] >= x.w()) return;

    var z: L = undefined;
    z.p = p;
    z.d = .{h, r};
    z.m = if (d) l.m + 1 else 1;

    var w: V = undefined;

    w.v = x.get2(p) + v.v;

    w.p = try v.p.clone();

    try w.p.append(z.p);

//    try err("mov", w.v);

    // go //
    _ = try lput(n, z, w);
}

fn lput(s: anytype, k: anytype, v: anytype) !bool {
    const g = s.*.get(k);

    if (g) |c| {
        if (v.v < c.v) {
            // Current bad //
            c.p.deinit();
            try s.*.put(k, v);
   
        } else {
            // Current good //
            v.p.deinit();
            return false;
 
        }

    } else {
        // New entry //
        try s.*.putNoClobber(k, v);

    }

    return true;
}

fn fin(a: anytype, i: anytype, j: anytype) !u64 {

    var e: V = undefined;
    
    e.v = 10000000000;

    var k = a.keyIterator();

    while (k.next()) |z| {

        const v = a.get(z.*) orelse unreachable;

        v.p.deinit();

        if (z.p[0] == i and z.p[1] == j) {

            if (v.v < e.v) e.v = v.v;
        }
    }
    
    if (dbg.*) try err("fin", e.v);

    return e.v;
}


// Draw //
fn phk(comptime l: anytype, a: anytype) void {

    if (!dbg.*) return;

    dpr("\n" ++ l ++ "[k]: ", .{});

    var k = a.keyIterator();

    while (k.next()) |v| {
        dpr("[{}, {}] ", .{v[0], v[1]});
    }

    dpr("\n", .{});
}

fn chc(a: anytype, i: anytype, j: anytype) bool {

    var k = a.keyIterator();

    while (k.next()) |v| {
        if (v.p[0] == i and v.p[1] == j)
            return true;
    }

    return false;
}

fn pra(a: anytype, s: anytype) void {

    pr("\n", .{});

    for (a.items(), 0..) |rr, i| {
        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        pr("   ", .{});

        for (r, 0..) |l, j| {

            if (chc(s, i, j))
                pr("#", .{})
            else
                pr(".", .{});
//                pr("{d}", .{l});

            _ = l;
        }

        pr("\n", .{});
    }

    pr("\n", .{});
}


// Main //
fn tmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

    const aoc = "17";
    const f = "data" ++ aoc ++ "-t.txt";

    const d = try ini(al, f, &n);
    defer al.free(d);

    if (n > 0) dbg.* = true;

    const a = try par(al, d);
    defer a.deinit();

//    out2("inp", a, null, con);

    const r = try run(al, a, n);
    res(r);
}


// Run //
pub fn main() !void {
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const al = are.allocator();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const al = gpa.allocator();

    try tmain(al, 0);
}


// Test //
test "main" {
    dbg.* = true;

    puts("", "");

    const al = std.testing.allocator;

    try tmain(al, 0);
}
