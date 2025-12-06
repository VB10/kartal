// Changing this constant during a minor package update may introduce breaking changes for consumers.
// This should only be modified as part of a major version increment.
// ignore_for_file: constant_identifier_names

/// Represents the type of a file.
/// The type can be one of the following: [IMAGE], [VIDEO], [AUDIO], [TEXT], or [UNKNOWN].
enum FileType { IMAGE, VIDEO, AUDIO, TEXT, UNKNOWN }
