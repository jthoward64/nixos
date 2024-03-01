{ ... }:
{
  # Pipewire
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.alsa.enable = true;
}
