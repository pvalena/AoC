
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
const sort = R.sort;
const sort2 = R.sort2;

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
const HashMap = R.HashMap;
const HashArray = R.HashArray;

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;
const num = R.num;
const chc = R.chc;


// Globals //
const dbg = &R.dbg;
const aoc = "19";


// Input //
const T = enum {
    L,
    M,
    R
};
fn dec(v: anytype) !T {
    return switch(v) {
        '<' => T.L,
        '>' => T.M,
        else => {
            try err("dec", v);
            return error.type;
        }
    };
}

const I = enum {
    x,
    m,
    a,
    s
};
fn ind(v: anytype) !u8 {
    return switch(v) {
        'x' => @intFromEnum(I.x),
        'm' => @intFromEnum(I.m),
        'a' => @intFromEnum(I.a),
        's' => @intFromEnum(I.s),
        else => {
            try err("ind", v);
            return error.type;
        }
    };
}

const U = struct {
    c: u8,
    o: T,
    n: u64,
    r: []const u8
};
const D = [4]u64;

//struct {
//    c: u8,
//    v: [4]u64
//};


//  //
//const T = enum {
//    fre,
//    set,
//};
//fn dis(t: anytype) u8 {
//    return switch(t) {
//        T.fre => '.',
//        T.set => '#',
//    };
//}
//const K = [2]u64;


// Data //
const A = genS(U);
//const B = gen(D);

//const A = Array(U);
const B = Array(D);

const C = struct {
    a: A,
    b: B,

    fn deinit(sl: anytype) void {
        sl.a.deinit();
        sl.b.deinit();
    }
};


// Logic //
fn par(al: anytype, d: []u8) !C {

    var c: C = undefined;

    c.a = try A.init(al);
    c.b = B.init(al);

    const a = &c.a;
    const b = &c.b;

//    try a.new();
//    try b.new();

    var i: u64 = 0;

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

        // Empty line
        if (l.len == 0) {

//            if (a.l.items.len > 0) {
                i += 1;
//                try a.new();
//            }
        
            continue;
        }

        if (i > 1) {
            try err("par; i", i);
        }

        var j: u64 = 0;

        var p: D = undefined;

        // Per elems
        var ws = spl(l, "{},");

        while (ws.next()) |w| {
            if (w.len == 0) continue;

            defer j += 1;

            _ = switch(i) {
                0 => {
                    try dat0(w, j, a);
                },

                1 => {
                    if (j >= 4) {
                        deb("j", j);
                        puts("w", w);

                        try err("par; j", j);
                    }

                    p[j] = try dat1(w);
                },

                else => 
                    try err("par; swi", i)
            };
        }

        if (i == 1) {
            try b.append(p);
        }

//        deb("par; a", .{a.l, a.d.get(a.l)});
//        try wip();
    }

    return c;
}

fn dat0(l: anytype, j: anytype, a: anytype) !void {
 
    if (j <= 0) {
        try a.new(l);
        return;
    }

    var u: U = undefined;

    var i: u64 = 0;

    if (l.len >= 3) {
        var s = spl(l[2..], ":");

        while (s.next()) |w| {

            defer i += 1;

            if (w.len == 0) {
                puts("l", l);

                try err("dat0; w", w);
            }

            u.r = w;

            if (i <= 0) {
                u.n = num(w, u64) catch 0;
            }
        }

    } else {
        u.r = l;

    }

    if (i == 2) {
        u.c = try ind(l[0]);
        u.o = try dec(l[1]);

    } else {
        if (i > 2) try err("dat0; i", i);

        u.o = T.R;
    }

    try a.add(u);
}


fn dat1(v: anytype) !u64 {

    var s = spl(v, "=");

    var i: u64 = 0;

    while (s.next()) |w| {
        defer i+= 1;

        if (i < 1) {
            assert(w.len == 1);

            _ = try ind(w[0]);
            continue;
        }
        if (i > 1) try err("dat1; i", i);

        assert(w.len >= 1);

        return try num(w, u64);
    }

    try err("dat1", v);
    return 0;
}


fn run(al: anytype, d: anytype, z: anytype) !u64 {

    if (z > 0) {
        dbg.* = true;
    }

    // Unused //
    _ = al;

    // Timestamp //
//    const t = tst();

//    // Result //
//    var b = B.init(al);
//    try b.new();
//    defer b.deinit();
//
//    var h = HashMap(u64, void).init(al);
//    defer h.deinit();
//
//    // Position //
//    const o = 10000000;
//    var p: K = .{ o, o };

    // Initial dig //
//    try b.putNoClobber(p, {});
//    try b.set2(.{o, p});

    // Input - first array only //
    const a = d.a;
    const b = d.b.items;

    for (b) |l| {
        try pla(&l, &a, "in");
    }

    // Evaluate //
//    return fin(&b, &c);
    return 0;
}

fn pla(
    l: anytype,
    a: anytype,
    y: anytype,
) !void {

    const x = a.get(y);
   
    deb("pla", .{l.*, y.*, x});

//    if (x.len == 0) {
//        switch (x[0]) {
//            'A' => try err("pla; A", x),
//            'R' => try err("pla; R", x),
//            else =>
//                try err("pla; swi", x)
//        }
//    }
//
//    if (x.o == T.R) {
//
//        try err("last", l.r);
//
//    }

    try wip();
}

fn fin(b: anytype, c: anytype) !u64 {

    var n: u64 = 0;

    // Borders //
    for (b.items()) |l| {

        for (l.keys()) |k| {

            n += k[1] - k[0] + 1;
        }
    }
    
    // Fill //
    for (c.items()) |l| {

        for (l.keys()) |k| {

            n += k[1] - k[0] - 1;

        }
    }
    
    return n;
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


fn pra(a: anytype) void {

    pr("\n", .{});

    for (a.items(), 0..) |rr, i| {

        _ = i;

        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        pr("   ", .{});

        for (r, 0..) |l, j| {

            _ = j;

            pr("{any}", l);
//            pr("{c}", .{dis(l)});
        }

        pr("\n", .{});
    }

    pr("\n", .{});
}


// Main //
fn rmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

    const f = "data" ++ aoc ++ "-t.txt";
//    const f = "data" ++ aoc ++ ".txt";

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
