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

const gen = R.gen;
const genH = R.genH;
const genS = R.genS;

const spl = R.spl;
const eql = R.eql;
const swp = R.swp;
const sort = R.sort;
const sort2 = R.sort2;
const num = R.num;
const sum = R.sum;


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
const DD = [2]D;

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

                    assert(p[j] != 0);
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

    }

    if (i == 2) {
        u.c = try ind(l[0]);
        u.o = try dec(l[1]);

    } else {
        if (i > 2) try err("dat0; i", i);

        u.r = l;
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
//    _ = al;

    // Timestamp //
    const t = tst();

    // Result //
//    var r: u64 = ;

    var h = HashArray(DD, void).init(al);
    defer h.deinit();

    // Input - first array only //
    const a = d.a;
//    const b = d.b.items;

//    const m: u64 = 20 + @abs(t) % 10;
    const m: u64 = 60 + @abs(t) % 10;

    for (1..4001) |v1| {

        if (v1 % m == 0) {} else continue;
        deb("run", .{v1, tst() - t});

    for (1..4001) |v2| {

        if (v2 % m == 0) {} else continue;

    for (1..4001) |v3| {

        if (v3 % m == 0) {} else continue;
    
    for (1..4001) |v4| {

        if (v4 % m == 0) {} else continue;

        const l: D = .{v1, v2, v3, v4};

        const e = .{0, 0, 0, 0};
        var r: DD = .{e, e};

        const q = try pla(&l, &a, "in", &r);

        if (q) {
            try h.put(r, {});
        }

    }}}}

    return try fin(&h);
//    return n;
}

fn pla(
    l: anytype,
    a: anytype,
    y: anytype,
    r: anytype
) !bool {

    if (y.len == 1) {
        switch (y[0]) {
            'A' => {
//                r.* += sum(l);
                return true;
            },
            'R' => return false,
            else => {}
        }
    }

    const u = try a.get(y);

    assert(u.items.len > 0);

    for (u.items) |x| {

//        deb("x", x);

        if (x.o == T.R) return try pla(l, a, x.r, r);

        const v = l[x.c];

        const s = switch (x.o) {
            T.L => v < x.n,
            T.M => v > x.n,
            else =>
                return error.swi
        };

        if (s) {

            const i = @intFromEnum(x.o);

            const g = r[i][x.c];

            if (g > 0) {
                if (x.o == T.L) {
                    if (x.n > g) r[i][x.c] = x.n;

                } else {
                    if (x.n < g) r[i][x.c] = x.n;

                }

            } else {

                r[i][x.c] = x.n;
            }

            return try pla(l, a, x.r, r);
        }
    }

    unreachable;
}

fn fin(h: anytype) !u64 {

    var n: u64 = 0;

    const k = h.keys();

    for (k, 0..) |r, j| {

        if (try mrg(r, k, j, h)) return fin(h);
    }

    for (k, 0..) |r, j| {
        const m = try mat(r, k, j);
        var c = cnt(r);

        if (c <= m) try err("fin", .{c, m});

        if (m > 0) {
            deb("fin; m", m);
            c -= m;
        }
 
        deb("fin; c", c); 

        n += c;
    }

    return n;
}

fn mrg(r: anytype, k: anytype, j: anytype, h: anytype) !bool {

    for (k, 0..) |o, l| {

        var n: u64 = 0;

        if (l >= j) continue;

//        var d: DD = undefined;

        var f: u64 = 2;

        for (0..4) |i| {

            const x = fet(r, i);
            const y = fet(o, i);

//                3..0     |     7..4
            if (x[0] < y[1] or y[0] < x[1]) break;

//            if (x[0] == y[0]) d[0][i] = x[0];
//            if (x[1] == y[1]) d[1][i] = x[1];

            if (x[0] == y[0] and x[1] == y[1]) {

                n += 1;
                continue;
            }

//            5..1 | 7..0
            if (x[0] <= y[0] and x[1] >= y[1]) {

                if (f == 0) {
//                    deb("f0", .{x,y});
                    break;
                }
                f = 1;

                n += 1;
                continue;
            }

            if (y[0] <= x[0] and y[1] >= x[1]) {

                if (f == 1) {
//                    deb("f1", .{x,y});
                    break;
                }
                f = 0;

                n += 1;
                continue;
            }

//            try err("mgr; ?", .{x, y});
            break;
        }

        if (n >= 4) {

            // remove o/r
            
            if (f == 1) {
                _ = h.orderedRemove(r);
                return true;
            }

            if (f == 0) {
                _ = h.orderedRemove(o);
                return true;
            }

            deb("o", o);
            deb("r", r);

            try err("f", f);
        }
    }

    return false;
}

fn mat(r: anytype, k: anytype, j: anytype) !u64 {

    var v: u64 = 0;

    for (k, 0..) |o, l| {

        var n: u64 = 1;

        if (l >= j) continue;

        for (0..4) |i| {

            const x = fet(r, i);
            const y = fet(o, i);

//            if (x[0] < y[1] or y[0] < x[1]) {
//                n = 0;
//                break;
//            }

//            if (x[0] == y[0] and x[1] == y[1]) {
//
//                n *= x[0] - x[1] - 1;
//                continue;
//            }

            if (x[0] >= y[0] and y[0] >= x[1]) {

                n *= y[0] - x[1] - 1;
                continue;
            }

            if (y[0] >= x[0] and x[0] >= y[1]) {

                n *= x[0] - y[1] - 1;
                continue;
            }

            if (x[0] < y[1]) {
                n = 0;
                break;
            }

//            deb("xy1", x[0] >= y[0]);
//            deb("xy2", x[1] <= y[0]);
//            deb("xy3", y[1] <= x[1]);

            try err("mat; ?", .{x, y});
            break;
        }

        if (n > 0) {
//            deb("mat", .{r, o});
            v += n;
        }
    }

    return v;
}

fn cnt(r: anytype) u64 {

    var m: u64 = 1;

    for (0..4) |i| {

        const x = fet(r, i);

        deb("x", x);

        m *= x[0] - x[1] - 1;
    }

//    deb("cnt", m);
    return m;
}

fn fet(r: anytype, i: anytype) [2]u64 {

    var x = .{r[0][i], r[1][i]};

    // T.L //
    if (x[0] <= 0 or x[0] > 4000) x[0] = 4001;

    // T.M //
    if (x[1] <= 0 or x[1] > 4000) x[1] = 0;

    return x;
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
