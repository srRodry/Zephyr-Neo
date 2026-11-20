package xendroid.compose.settings

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test
import org.tomlj.Toml

class GuestLocaleConfigTest {
    @Test
    fun savesPortugueseAndBrazilWithOtherSettingsIntact() {
        val before = """
            [Console]
            user_language = 1
            user_country = 103
            user_xuid = "123456789"
            [GPU]
            draw_resolution_scale_x = 1.5
            sample_names = ["a", "b"]
            [GPU."custom.table"]
            enabled = true
        """.trimIndent()

        val after = Toml.parse(GuestLocaleConfig.edit(before, 9, 13))
        assertFalse(after.errors().toString(), after.hasErrors())
        assertEquals(9L, after.getLong("Console.user_language"))
        assertEquals(13L, after.getLong("Console.user_country"))
        assertEquals("123456789", after.getString("Console.user_xuid"))
        assertTrue(Toml.equals(Toml.parse(before).getTable("GPU")!!, after.getTable("GPU")!!))
    }

    @Test
    fun addsOnlyProvidedValuesAndDoesNotRewriteAnUnchangedFile() {
        val after = GuestLocaleConfig.edit("[Audio]\nvolume = 0.75", null, 13)
        val table = Toml.parse(after)
        assertFalse(table.errors().toString(), table.hasErrors())
        assertEquals(13L, table.getLong("Console.user_country"))
        assertFalse(table.contains("Console.user_language"))
        assertEquals(after, GuestLocaleConfig.edit(after, null, 13))
    }

    @Test
    fun refusesToReplaceInvalidConfig() {
        assertThrows(IllegalArgumentException::class.java) {
            GuestLocaleConfig.edit("[Console\nuser_language = 1", 9, 13)
        }
        assertThrows(IllegalArgumentException::class.java) {
            GuestLocaleConfig.edit("Console = 42", 9, 13)
        }
    }
}
