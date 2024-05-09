
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
const num = R.num;
const chc = R.chc;


// Globals //
const dbg = &R.dbg;
const aoc = "18";


// Input //
const D = enum {
    U,
    R,
    D,
    L
};
fn dec(v: anytype) !D {
    return switch(v) {
        'U' => D.U,
        'R' => D.R,
        'D' => D.D,
        'L' => D.L,
        else => return error.type
    };
}
const I = struct {
    d: D,
    n: u64,
};


// Output //
const T = enum {
    fre,
    set,
};
fn dis(t: anytype) u8 {
    return switch(t) {
        T.fre => '.',
        T.set => '#',
    };
}
const K = [2]u64;


// Data //
const A = gen(I);
const B = genH(K);
const C = genH(K);


// Logic //
fn par(al: anytype, d: []u8) !A {

    // Multi-Data
    var a = A.init(al);
    try a.new();

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

        // Empty line
        if (l.len == 0) {

//            if (a.l.items.len > 0) {
//                try a.new();
//            }
        
            continue;
        }

        // Per elems
        var ws = spl(l, " ");
        var i: u64 = 0;

        var z: I = undefined;

        while (ws.next()) |w| {
            defer i += 1;

            if (w.len == 0) {
                try err("zero", l);
                continue;
            }

//            puts("w", w);

            _ = switch(i) {
                0 => {
                    continue;
                },
                1 =>
                    continue,
                2 => 
                    try dat(w, &z),
                else => 
                    try err("par: swi", l)
            };

        }

        try a.add(z);

//        break;
    }

    return a;
}

fn dat(v: anytype, z: anytype) !void {

    const i = 2;
    const s = v[i..i+5];

    z.n = fmt.parseUnsigned(u64, s, 16) catch |e| {
        puts("s", s);
        err("dat: hex", s) catch {};

        return e;
    };

    const j = 7;
    const t = v[j];

    z.d = switch(t) {
        '3' => D.U,
        '0' => D.R,
        '1' => D.D,
        '2' => D.L,
        else => {
            try err("dat: swi", t);
            return error.type;
        }
    };

//    deb("dat", z);
//    try wip();
}


fn run(al: anytype, d: anytype, z: anytype) !u64 {

    if (z > 0) {
        dbg.* = true;
    }

    // Unused //
//    _ = d;
//    _ = al;

    // Timestamp //
//    const t = tst();

    // Result //
    var b = B.init(al);
    try b.new();
    defer b.deinit();

    var c = C.init(al);
    try c.new();
    defer c.deinit();

    var h = HashMap(u64, void).init(al);
    defer h.deinit();

    // Position //
    const o = 10000000;
    var p: K = .{ o, o };

    // Initial dig //
//    try b.putNoClobber(p, {});
    try b.set2(.{o, p});

    // Input - first array only //
    const x = d.l;

    for (x.items) |l| {
        try pla(&l, &p, &b, &h);
    }

//    pra(b);

    deb("b", b.items().len);

    // Part 2 //
    try fil(al, &b, &c, &h);

    // Evaluate //
    return fin(&b, &c);
//    return 0;
}

fn pla(
    l: anytype,
    p: anytype,
    b: anytype,
    h: anytype,
) !void {

//    deb("pla", .{p, l.d, l.n});
//    if (l.n > 0) return;

//    var i = p[0];
//    var j = p[1];    

    if (l.d == D.R or l.d == D.L) {

//        n = p[1] + (l.n * o);
//        z = .{ p[0], .{ p[1] + o, n }};

        if (l.d == D.L and p[1] < l.n) {
            try err("pla: L", .{p.*, l.n});
        }

        var z = switch (l.d) {

            D.R => .{ p[0], .{ p[1] + 1, p[1] + l.n }},
            D.L => .{ p[0], .{ p[1] - 1, p[1] - l.n }},

            else => unreachable
        };

        // Next position //
        p[1] = z[1][1];

        // Ordered coords //
        if (z[1][1] < z[1][0]) swp(&z[1][1], &z[1][0]);

        try h.put(p[0], {});

//        deb("z", z);
        
        try b.set2(z);
        return;
    }

    for (0..l.n) |_| {
        _ = switch(l.d) {
            D.D =>
                p[0] += 1,

            D.U => {
                if (p[0] <= 0) {
                    try err("pla: U", .{p.*, l.n});
                }
                p[0] -= 1;
            },

            else => unreachable
        };

        const z = .{p[0], .{p[1], p[1]}};

        try b.set2(z);
    }
}

// Innards //
fn fil(
    al: anytype,
    b: anytype,
    c: anytype,
    h: anytype,
) !void {

//    var n: u64 = 0;

    // pad //
    try b.new();

    for (b.items(), 0..) |ll, i| {

        const lc = ll.count();

        if (lc <= 0) continue;

        var l = ll.keys();

        sort2(&l);

        try chcL(l, i, c);
    }

//    deb("f", try fin(b, c) );

    deb("c", c.items().len);

    const t = tst();

    for (c.items(), 0..) |ll, x| {
        if (ll.count() <= 0) continue;

        const l = ll.keys();

        for (l) |r| {

            // Fill horizontal lines //
            if (x > 0) {
                if (chc(h, x-1)) try filR(al, b, c, x-1, r);
            }
            if (chc(h, x+1)) try filR(al, b, c, x+1, r);
        }

        if (x % 1000000 == 0) {
            deb("x", .{x, tst() - t});
        }
    }

    deb("c", c.items().len);
}

fn chcL(l: anytype, x: anytype, c: anytype) !void {

    var z: u64 = 0;
    var i = l[z];

    const ll = l.len - 1;

    var s = true;

    // Loop //
    while (z < ll) {
        z += 1;

        if(i[0] != i[1]) return;

        const ii = i[0];

        // Next = empty //
        if (try wal(l, ii + 1)) return;

        const j = l[z];
        const jj = j[0];

        assert(j[0] <= j[1]);
        
        if (s) {   
            _ = try setx(c, x, ii, jj);
        }

        i = j;
        s = !s;
    }
}

fn filR(al: anytype, b: anytype, c: anytype, x: anytype, g: anytype) !void {

//    _ = al;

    var s: u64 = 0;

    assert(x < b.items().len);

    var l = b.items()[x].keys();
    const ll = l.len - 1;

    sort2(&l);

    var k: u64 = 0;

    for (g[0]+1..g[1]) |z| {

        if (s > z) continue;

        // Don't hit the wall //
        if (!try wal(l, z)) {

            // Look up borders //
            while (k < ll) {

                const i = l[k][1];
                const j = l[k+1][0];

                assert(i < j);
            
                if (i < z and z < j) {

                    const y = try setx(c, x, i, j);

                    if (y) {
                        const r = .{i, j};
                    
                        deb("filR", .{x, r});

                        // rec //
                        if (x > 0) try filR(al, b, c, x-1, r);
                        try filR(al, b, c, x+1, r);
                    }
                    
                    s = j;
                    break;
                }

                k += 1;
            }

            if (k >= ll) return;
        }
    }
}

fn wal(l: anytype, z: anytype) !bool {

//    CHC:
//            const v = ll.get(cc);
//
//            if (v) |_| {
//                return true;
//            }
//

    for (l) |k| {
        const i = k[0];
        const j = k[1];

        if (i <= z and z <= j) {
            return true;
        }
    }

    return false;
}

fn setx(c: anytype, x: anytype, i: anytype, j: anytype) !bool {

    assert(i < j);

    const r = .{i, j};

    if (!c.chc(x, r)) {
        try c.set2(.{x, r});

        return true;
    }

    return false;

//    var f = HashMap(K, void).init(al);
//    defer f.deinit();
//
//    var n = HashMap(K, void).init(al);
//    defer n.deinit();
//
//    try f.put(p, {});
//         
//    while (f.count() > 0) {
//
//        n.clearRetainingCapacity();
//
//        var q = f.keyIterator();
//
//        while (q.next()) |k| {
//
//            const i = k[0];
//            const j = k[1];
//
//            // EnQueue! //
//            try bchc(b, &n, i, j+1);
//            try bchc(b, &n, i, j-1);
//
//            try bchc(b, &n, i+1, j);
//            try bchc(b, &n, i-1, j);
//        }
//
//        swp(&f, &n);
//    }
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

            pr("{c}", .{dis(l)});
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
