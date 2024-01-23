
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

const split = R.split;
const eql = R.eql;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
const err = R.err;
const pr = R.pr;

const lin = R.lin;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;
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
const Ti = []const u8;
const Di = gen(Ti);

const L = struct {
    l: Ti,
    n: u64,
};
const B = gen(L);


// Input //
fn par(al: anytype, d: []u8) !Di {

    // Multi-Data
    var a = Di.init(al);
    try a.new();

    // Line
    var ls = split(d, "\n");

    while (ls.next()) |l| {
//        if (l.len == 0) {

//            if (a.l.items.len > 0) {
//                try a.new();
//            }
//        
//            continue;

//            break;
//        }

        // Elems
        var ws = split(l, ",");
        var i: u64 = 0;

        while (ws.next()) |w| {
            defer i += 1;

//            puts("w", w);

            if (w.len == 0) {
//                try err("zero", l);
                continue;
            }

//            try a.new();
            try a.add(w);
//            try dat(a, w, i);
        }
    }

//    try a.append(d);
    return a;
}

fn dat(x: anytype, w: anytype, i: anytype) !void {

//    if (i == 0) {
//        var f = true;

//        puts("w", w);

        for (w) |v| {

//            try err("Entry", v);
//            const t = try dec(v);
//
//            if (!(f and t == T.fre)) {
                try x.add(v);
//
//                f = false;
//            }
        }
//
//        return;
//    }

    try err("Invalid entry", w);
    _ = i;
//    _ = x;

//    return;

//    var ns = split(w, ",");

//    while (ns.next()) |n| {
//        if (n.len == 0) continue;

//        if (n[0] >= '0' and n[0] <= '9') {
//            const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
//                err("Invalid int", n) catch {};
//
//                return e;
//            };
//        } else {
//            try err("Invalid number", n);
//
//        }
//    }
}
//fn dec(v: anytype) !T {
//    return switch(v) {
//        '#' => T.roc,
//        '.' => T.fre,
//        'O' => T.set,
//
//        else => return error.type
//    };
//}


// Output //
//fn con(t: anytype) u8 {
//    return switch(t) {
//        T.roc => '#',
//        T.set => 'O',
//        T.fre => '.',
//    };
//}


// Logic //
fn run(al: anytype, d: anytype, b: anytype) !u64 {

//    _ = b;

    const w = d.items()[0].items;

    var r: u64 = 0;
    r += 0;

    var a = B.init(al);
    defer a.deinit();

    for (0..256) |_| {
        try a.new();
    }

//    try err("h", a.h());

//    const m = 1000000000;
//    const n = m / 1000;

//    Timestamp
//    const t = tst();

    const x = a.d;
    
    for (w, 0..) |v, i| {
//        _ = i;

//        puts("v", v);
//        try err("v", .{i, v});

//        const z = x.items;
//        if (x.h == 0) continue;

//        if (i % n == 0) {
//            const o = dbg.*;
//            dbg.* = true;


            try opr(x, v);

            pri(x);

//            r += q;

//            pr("{}: {} ({})\n", .{i, q, tst() - t});

            if (dbg.* and b > 0 and i >= b-1) {
//                out2("cyc", d, null, con);
                break;
            }

//            dbg.* = o;
//        }
    }

//    dbg.* = true;
//    out2("end", d, null, con);

    r = pow(a);

//    try err("r", r);

    return r;
}

fn opr(aa: anytype, w: anytype) !void {

    const a = aa.items;

    puts("opr", w);

    var ns = split(w, "=");

    var l: L = undefined;

    var i: u64 = 0;

    while (ns.next()) |v| {

        defer i += 1;

        if (i <= 0) {

            if (v.len == 0) try err("len", 0);

            l.l = v;

        } else {
            l.n = try num(v);

        }
    }

    if (i <= 0) try err("opr", 0);

    if (i <= 1) {
        var cl = split(l.l, "-");

        while (cl.next()) |v| {
            if (v.len <= 0) continue;

            l.l = v;
        }

        const b = cal(l.l);

        a[b] = try rem(a[b], l.l);

    } else {
        const b = cal(l.l);

        a[b] = try rep(a[b], l);
    }
}

fn rep(aa: anytype, l: anytype) !Array(L) {

    var a = aa;

    const e = a.items.len;

    try a.append(l);

    if (fin(a, l.l)) |i| {
        if (i != e) _ = a.swapRemove(i);
    }

    return a;
}

fn fin(a: anytype, l: anytype) ?usize {
    var z: ?usize = null;

    for (a.items, 0..) |v, i| {

        if (eql(v.l, l)) {
            z = i;
            break;
        }
    }

    return z;
}

fn rem(aa: anytype, l: anytype) !Array(L) {

    var a = aa;

    const z = fin(a, l);

    if (z) |i| {
        _ = a.orderedRemove(i);       
    }

    return a;
}

fn pow(a: anytype) u64 {

    var e: u64 = 0;

    for (a.items(), 1..) |r, b| {
        for (r.items, 1..) |l, s| {

            e += b * s * l.n;
        }
    }

    return e;
}

fn pri(a: anytype) void {

    for (a.items, 0..) |rr, b| {
        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        pr("Box {}: ", .{b});

        for (r) |l| {

            pr("[{s} {d}] ", l);
        }

        pr("\n", .{});
    }

    pr("\n", .{});
}

fn cal(
    w: anytype,

) u8 {

    var y: u64 = 0;

    for (w) |v| {
        y += v;
        y *= 17;
        y %= 256;
    }

    return @intCast(y);
}


// Main //
fn tmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

    const aoc = "15";
    const f = "data" ++ aoc ++ "-t.txt";

    const d = try ini(al, f, &n);
    defer al.free(d);

    if (n > 0) dbg.* = true;

    const a = try par(al, d);
    defer a.deinit();

//    var q = Array(u64).init(al);
//    defer q.deinit();

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
