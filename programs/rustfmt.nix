{ lib, pkgs, config, ... }:
let
  cfg = config.programs.rustfmt;
in
{
  options.programs.rustfmt = {
    enable = lib.mkEnableOption "rustfmt";
    edition = lib.mkOption {
      type = lib.types.str;
      default = "2021";
      description = ''
        Rust edition to target when formatting
      '';
    };
    package = lib.mkPackageOption pkgs "rustc" { };
  };

  config = lib.mkIf cfg.enable {
    settings.formatter.rustfmt = {
      command = "${cfg.package}/bin/rustfmt";
      options = [ "--edition" cfg.edition ];
      includes = [ "*.rs" ];
    };
  };
}
