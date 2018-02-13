/*
 * Copyright (c) 2018 elementary LLC. (https://github.com/elementary/vala-lint)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */

class FileTest : Object {

    public static int main (string[] args) {

        var linter = new ValaLint.Linter ();

        var mistakes = linter.run_checks_for_file (File.new_for_path ("../test/files/IconRenderer.vala"));
        assert (mistakes.size == 0);

        mistakes = linter.run_checks_for_file (File.new_for_path ("../test/files/PantheonTerminalWindow.vala"));
        assert (mistakes.size == 1);
        assert_includes (mistakes, "block-opening-brace-space-before", 1122);

        mistakes = linter.run_checks_for_file (File.new_for_path ("../test/files/TextRenderer.vala"));
        assert (mistakes.size == 3);
        assert_includes (mistakes, "block-opening-brace-space-before", 313);
        assert_includes (mistakes, "block-opening-brace-space-before", 316);
        assert_includes (mistakes, "block-opening-brace-space-before", 327);

        return 0;
    }

    private static void assert_includes (Gee.ArrayList<ValaLint.FormatMistake?> mistakes,
                                            string title,
                                            int line_pos,
                                            int char_pos = -1) {
        foreach (var m in mistakes) {
            if (m.check.get_title () == title && m.line_index == line_pos) {
                if (char_pos == -1 || (char_pos > -1 && m.char_index == char_pos)) {
                    return;
                }
            }
        }
        assert (false);
    }
}