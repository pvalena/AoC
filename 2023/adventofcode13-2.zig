
// Import //
const R = @import("class.zig");

const std = R.std;

const split = R.split;
const fmt = R.fmt;
const io = R.io;
const debug = R.debug;
const assert = R.assert;
const stdout = R.stdout;

const err = R.err;
const putd = R.putd;
const puts = R.puts;
const ini = R.ini;
const res = R.res;
const deb = R.deb;
const lin = R.lin;

const Array = R.Array;


// Globals //
const dbg = &R.dbg;
const aoc = "13";


// Types //
const T = enum {
    set,
    fre,
};
const N = Array(Array(T));


// Data //
const D = struct {
    al: std.mem.Allocator,
    d: Array(N),
    l: *N,

    fn init(al: anytype) D {
        var s: D = undefined;

        s.al = al;
        s.d = Array(N).init(al);
        
        return s;
    }

    fn new(sl: anytype) !void {
        const l = N.init(sl.al);

        try sl.d.append(l);

        const i = sl.d.items;

        sl.l = &i[i.len-1];
    }

    fn row(sl: anytype) !*Array(T) {
        const n = Array(T).init(sl.al);

        try sl.l.append(n);

        const i = sl.l.items;

        const r = &i[i.len-1];

        return r;
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


// Logic //
fn par(al: anytype, d: []u8) !D {

    // Multi-Data
    var a = D.init(al);

    // Data
    try a.new();

    // Line
    var ls = split(u8, d, "\n");

    while (ls.next()) |l| {
        if (l.len == 0) {

            if (a.l.items.len > 0) {
                try a.new();
            }
        
            continue;
        }

        // Elems
        var ws = split(u8, l, " ");
        var i: u64 = 0;

        while (ws.next()) |w| {
            defer i += 1;

            if (w.len == 0) {
                try err("now", l);
                continue;
            }

            const r = try a.row();
            try dat(r, w, i);
        }
    }

//    try a.append(d);
    return a;
}

//fn dat(y: anytype, w: anytype, i: anytype) !@TypeOf(y) {
fn dat(x: anytype, w: anytype, i: anytype) !void {

    if (i == 0) {
        var f = true;

        for (w) |v| {
            const t = switch(v) {
                '#' => T.set,
                '.' => T.fre,

                else => return error.type
            };

//            if (!(f and t == T.fre)) {
                try x.append(t);

                f = false;
//            }
        }

        return;
    }

    try err("Invalid entry", w);

    return;

//    var ns = split(u8, w, ",");
//
//    while (ns.next()) |n| {
//        if (n.len == 0) continue;
//
//        if (n[0] >= '0' and n[0] <= '9') {
//            const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
//                err("Invalid int", n) catch {};
//
//                return e;
//            };
//
////            deb("Number", v, "d");
//
//            try x.s.append(v);
//            try x.x.append(v);
//
//        } else {
//            try err("Invalid number", n);
//
//        }
//    }
}

fn run(dd: anytype, n: anytype) !u64 {

    _ = n;

    const d = dd.d.items;

    var r: u64 = 0;

//    const b = 0;
    const b = 1000_000;
//    const odbg = dbg;

    for (d, 0..) |x, i| {

//        dbg = if (i >= b and odbg) true else false;

        const z = x.items;

        if (z.len <= 0) continue;

//        var v: u64 = 0;

        var q = try lrs(z);

        if (q > 0) {
            r += q;
            
        } else {
            q = try tds(z);

            if (q == 0)
                try err("nf", i);

            r += 100*q;

        }

        try stdout.print("q: {}, {}\n\n", .{i, q});
        if (i >= b) break;
    }

    return r;
}

fn out(comptime l: anytype, f: anytype, s: ?[]u64) void {
    if (!dbg.*) return;

    debug.print(l ++ ": ", .{});
    for (f) |t| {
        const v: u8 = switch(t) {
            T.set => '#',
            T.fre => '.',
        };

        debug.print("{c}", .{v});
    }

    if (s) |ss| {
        debug.print(" <- ", .{});

        for (ss) |v| {
            debug.print("{} ", .{v});
        }
    }
    debug.print("\n", .{});
}

fn lrs(
    d: anytype,

) !u64 {

    const w = d[0].items.len;

    var y: u64 = 0;

    for (1..w) |x| {

        putd("");
        deb(">>> x", x, "");

        var f: u64 = 2;

        for (d) |rr| {

            const r = rr.items;

            putd("");
            out("lrs", r, null);

            var j = x;

            for (x..r.len) |i| {

                if (j == 0) break;
                j -= 1;

                lin("j", j);
                lin("i", i);

                const l = r[j];
                const k = r[i];
                
                if (l != k) {
                    f -= 1;
    
                    if (f < 1) break;
                }                    

            }

            if (f < 1) {
                break;
            }
        }

        if (f == 1) {
            y = x;

            break;
        }
        
    }

    return y;
}

//fn get(d, r, x) T {
//    
//}

fn tds(
    d: anytype,

) !u64 {

    const w = d[0].items.len;
    const h = d.len;

    var y: u64 = 0;

    for (1..h) |x| {

        putd("");
        deb(">>> x", x, "");

        var f: u64 = 2;

        for (0..w) |c| {

//            putd("");
//            outv("tds", r, null);

            var j = x;

            for (x..h) |i| {

                if (j == 0) break;
                j -= 1;

                deb("j", j, "");
                deb("i", i, "");

                const l = d[j].items[c];
                const k = d[i].items[c];
                
                if (l != k) {
                    f -= 1;
    
                    if (f < 1) break;
                }                    

            }

            if (f < 1) break;
        }

        if (f == 1) {
            y = x;

            break;
        }
        
    }

    return y;
}


// Main //
fn tmain(al: anytype) !void {
    puts("");

    var n: u64 = 0;

    const f = "data" ++ aoc ++ "-t.txt";

    const d = try ini(al, f, &n);
    defer al.free(d);

    const a = try par(al, d);
    defer a.deinit();

    const r = try run(a, n);

    res(r, "d");
}


// Run //
pub fn main() !void {
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const al = are.allocator();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const al = gpa.allocator();

    try tmain(al);
}


// Test //
test "main" {
    dbg.* = true;

    putd("");

    const al = std.testing.allocator;

    try tmain(al);
}
