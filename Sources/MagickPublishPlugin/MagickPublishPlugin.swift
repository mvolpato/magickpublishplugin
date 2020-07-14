/**
 *  Magick-plugin for Publish
 *  Copyright (c) Michele Volpato 2020
 *  MIT license, see LICENSE file for details
 */

import Publish
import ShellOut

public extension Plugin {

    /// Runs a ImageMagick `magick` command on a single file.
    ///
    /// - Parameters:
    ///   - executablePath: the path to the magick executable. Default to `/usr/local/bin`.
    ///   - arguments: the arguments for the magick command, one element for each argument.
    ///   - file: the path to the file, this will be appended to the argument list.
    static func magick(executablePath: String = "/usr/local/bin",
                       arguments: [String],
                       imageFile file: Path) -> Self {
        Plugin(name: "Magick custom command for \(file)") { context in
            guard let contextPath = try? context.file(at: file) else {
                print("Cannot find file.")
                return
            }
            do {
                try shellOut(to: "\(executablePath)/magick \(arguments.joined(separator: " ")) \(contextPath.path)")
            } catch {
                let error = error as! ShellOutError
                print(error.message)
                print(error.output)
            }
        }
    }

    /// Runs a ImageMagick `magick` command on all files in a folder.
    ///
    /// - Parameters:
    ///   - executablePath: the path to the magick executable. Default to `/usr/local/bin`.
    ///   - arguments: the arguments for the magick command, one element for each argument.
    ///   - folder: the path to the folder, this will be appended to the argument list.
    static func magick(executablePath: String = "/usr/local/bin",
                       arguments: [String],
                       imagesFolder folder: Path) -> Self {
        Plugin(name: "Magick custom command at \(folder)") { context in
            guard let contextPath = try? context.folder(at: folder) else {
                print("Cannot find folder.")
                return
            }
            do {
                try shellOut(to: "\(executablePath)/magick \(arguments.joined(separator: " ")) \(contextPath.path)*.*")
            } catch {
                let error = error as! ShellOutError
                print(error.message)
                print(error.output)
            }
        }
    }

    /// Runs a predefined ImageMagick `magick mogrify` command on all files in a folder.
    ///
    /// - NOTE: The list of argument has been taken from https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/
    /// 
    /// - Parameter folder: the path to the folder, this will be appended to the argument list.
    static func optimizeForWeb(imagesInFolder folder: Path) -> Self {
        Plugin(name: "Magick optimize for web at \(folder)") { context in
            guard let contextPath = try? context.folder(at: folder) else {
                print("Cannot find folder.")
                return
            }

            let arguments = [
                "mogrify",
                "-filter",
                "Triangle",
                "-define",
                "filter:support=2",
                "-unsharp",
                "0.25x0.25+8+0.065",
                "-dither",
                "None",
                "-posterize",
                "136",
                "-quality",
                "82",
                "-define",
                "jpeg:fancy-upsampling=off",
                "-define",
                "png:compression-filter=5",
                "-define",
                "png:compression-level=9",
                "-define",
                "png:compression-strategy=1",
                "-define",
                "png:exclude-chunk=all",
                "-interlace",
                "none",
                "-colorspace",
                "sRGB",
                "-strip",
                "\(contextPath.path)*.*"]

            do {
                try shellOut(to: "/usr/local/bin/magick \(arguments.joined(separator: " "))")
            } catch {
                let error = error as! ShellOutError
                print(error.message)
                print(error.output)
            }
        }
    }
}


