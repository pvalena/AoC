
// Import //
const R = @import("class.zig");

const std = R.std;

const split = R.split;
const fmt = R.fmt;
const io = R.io;
const debug = R.debug;
const assert = R.assert;
const stdout = R.stdout;
const tst = R.tst;
const pr = R.pr;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
const err = R.err;

const lin = R.lin;

const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;


// Globals //
const dbg = &R.dbg;


// Types //
//const T = enum {
//    set,
//    fre,
//    roc,
//};
const T = []const u8;
const N = Array(T);
const N3 = Array(Array(T));


// Data //
const D = struct {
    al: std.mem.Allocator,
    d: Array(N),
    l: *N,

    pub fn init(al: anytype) D {
        var s: D = undefined;

        s.al = al;
        s.d = Array(N).init(al);
      
        return s;
    }

    pub fn items(sl: anytype) []N {
        return sl.d.items;
    }

    pub fn h(sl: anytype) usize {
        return sl.d.items.len;
    }

    pub fn w(sl: anytype) usize {
        return sl.l.items.len;
    }

    pub fn new(sl: anytype) !void {
        const l = N.init(sl.al);

        try sl.d.append(l);

        const i = sl.d.items;

        sl.l = &i[i.len-1];
    }

    pub fn add(sl: anytype, v: anytype) !void {
        try sl.l.append(v);
    }

    pub fn get(sl: anytype, ii: anytype, cc: anytype) T {

        const i: usize = @intCast(ii);
        const c: usize = @intCast(cc);

        return sl.d.items[i].items[c];
    }

    pub fn set(
        sl: anytype, ii: anytype, jj: anytype,
        t: anytype
    ) !void {

        const i: usize = @intCast(ii);
        const j: usize = @intCast(jj);

        const c = sl.d.items;
    
        assert(i < c.len);

        const r = c[i].items;

        assert(j < r.len);

        const x = r[j];

        _ = switch(t) {
            T.set => assert(x == T.fre),
            T.fre => assert(x == T.set),

            else => {
                try err("set", t);
            }
        };

        r[j] = t;
    }

    pub fn deinit(sl: anytype) void {
        for (sl.d.items) |i| {
            i.deinit();

        }
        sl.d.deinit();
    }
};
const D3 = struct {
    al: std.mem.Allocator,
    d: Array(N3),
    l: *N3,
    w: u64,
    h: u64,

    fn init(al: anytype) D {
        var s: D = undefined;

        s.al = al;
        s.d = Array(N3).init(al);

        s.h = 0;
        s.w = 0;
        
        return s;
    }

    fn new(sl: anytype) !void {
        const l = N3.init(sl.al);

        try sl.d.append(l);

        const i = sl.d.items;

        sl.h = i.len;

        sl.l = &i[i.len-1];
    }

    fn row(sl: anytype) !*N {
        const n = N.init(sl.al);

        try sl.l.append(n);

        const i = sl.l.items;

        if (i.len > sl.w) sl.w = i.len;

        return &i[i.len-1];
    }

    fn get(sl: anytype, j: anytype, c: anytype, k: anytype) T {
        return sl.d.items[j].items[c].items[k];
    }

    fn deinit(sl: anytype) void {
        for (sl.d.items) |i| {
            
            for (i.items) |j| {

                j.deinit();

            }
            i.deinit();

        }
        sl.d.deinit();
    }
};

// Print //
fn con(t: anytype) u8 {
    return switch(t) {
        T.roc => '#',
        T.set => 'O',
        T.fre => '.',
    };
}


// Input //
fn par(al: anytype, d: []u8) !D {

    // Multi-Data
    var a = D.init(al);
    try a.new();

    // Line
    var ls = split(u8, d, "\n");

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
        var ws = split(u8, l, ",");
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

//    var ns = split(u8, w, ",");

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

fn dec(v: anytype) !T {
    return switch(v) {
        '#' => T.roc,
        '.' => T.fre,
        'O' => T.set,

        else => return error.type
    };
}

// Logic //
fn run(d: anytype, b: anytype) !u64 {

    _ = b;

    const w = d.items()[0].items;

    var r: u64 = 0;
    r += 0;

//    const m = 1000000000;
//    const n = m / 1000;

//    Timestamp
    const t = tst();
    
    for (w, 0..) |v, i| {
//        puts("v", v);
//        try err("v", .{i, v});

//        const z = x.items;
//        if (x.h == 0) continue;

//        if (i % n == 0) {
//            const o = dbg.*;
//            dbg.* = true;

            const q = try cal(v);
            r += q;

            pr("{}: {} ({})\n", .{i, q, tst() - t});

//            if (dbg.* and b > 0 and i >= b-1) {
//                out2("cyc", d, null, con);
//                break;
//            }

//            dbg.* = o;
//        }
    }

//    dbg.* = true;
//    out2("end", d, null, con);

//    const r = try cal(d);

    return r;
}


fn cal(
    w: anytype,

) !u8 {

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

    const r = try run(a, n);

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